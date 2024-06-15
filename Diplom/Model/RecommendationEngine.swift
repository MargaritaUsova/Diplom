//
//  RecommendationEngine.swift
//  Diplom
//
//  Created by Margarita Usova on 31.05.2024.
//

import Foundation
import CoreML
import YandexMapsMobile


class RecommendationEngine{    
    private var model: VenueRecommender?
    private var averageBill = ""
    private var cost: String?
    static var recommendations = [RecommendationsStruct]()
    private var userFavouritePlaces = [Venue]()
    private var searchSession: YMKSearchSession?
    private var parsedData = Set<SearchResponseItem>()
    private var searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
    private var searchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        options.snippets = YMKSearchSnippet.photos
        options.resultPageSize = 1000
        return options
    }()
    
    private let polygon: YMKPolygon = {
        var points = [
            YMKPoint(latitude: 55.917, longitude: 37.442),
            YMKPoint(latitude: 55.917, longitude: 37.822),
            YMKPoint(latitude: 55.566, longitude: 37.822),
            YMKPoint(latitude: 55.566, longitude: 37.442)
        ]
        points.append(points[0]) 
        let outerRing = YMKLinearRing(points: points)
        return YMKPolygon(outerRing: outerRing, innerRings: [])
    }()
    
    private var placesNearby = [PlacePredictionInput]()
    
    func makePrediction(){
        do {
            model = try? VenueRecommender(configuration: MLModelConfiguration())
            userFavouritePlaces = prepareCoreData()
            search()
            
        } catch {
            fatalError("Error initializing model: \(error)")
        }
    }
    
    private func prepareCoreData() -> [Venue]{
        var dataFromCoreData = [Venue]()
        let data = FavouritePlacesDBManager().fetchFavouritePlaces()
        for place in data{
            if let name = place.name,
               let categories = place.categories as? [String]{
                let averageBill = convertBills([place.priceRange])
                print("categories: ", categories, "\n")
                let placeData = Venue(name: name,
                                      isChildFriendly: place.childrenRoom ? 1 : 0,
                                      hasAlcohol: 0,
                                      wheelChairAccess: place.disabledAccess ? 1 : 0,
                                      averageBill: Double(averageBill),
                                      Bakery: categories.contains("Пекарня") ? 1 : 0,
                                      CoffeeShop: categories.contains("Кофейня") ? 1 : 0,
                                      Pizzeria: categories.contains("Пиццерия") ? 1 : 0,
                                      Cafe: categories.contains("Кафе") ? 1 : 0,
                                      TakeawayCoffee: categories.contains("Кофе с собой") ? 1 : 0,
                                      TakeawayFood: categories.contains("Еда на вынос") ? 1 : 0,
                                      Food: categories.contains("Фудмолл, гастромаркет") ? 1 : 0,
                                      Confectionery: categories.contains("Кондитерская") ? 1 : 0,
                                      IceCream: categories.contains("Мороженое") ? 1 : 0,
                                      Bar: categories.contains("Бар, паб") ? 1 : 0,
                                      SushiBar: categories.contains("Суши-бар") ? 1 : 0,
                                      Restaurant: categories.contains("Ресторан") ? 1 : 0,
                                      TakeawayMeals: categories.contains("Еда с собой") ? 1 : 0,
                                      Pub: categories.contains("Спортбар") ? 1 : 0,
                                      FastFood: categories.contains("Быстрое питание") ? 1 : 0,
                                      Canteen: categories.contains("Столовая") ? 1 : 0)
                dataFromCoreData.append(placeData)
            }
        }
        
        return dataFromCoreData
    }
    
    private func search(){
        searchSession?.cancel()
        searchSession = searchManager.submit(
            withText: "где поесть",
            geometry: YMKGeometry(polygon: polygon),
            searchOptions: searchOptions,
            responseHandler: handleSearchSessionResponse
        )
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error = error {
            print("Ошибка запроса при поиске данных для рекомендательной системы: ", error)
            return
        }

        guard let response = response,
              let boundingBox = response.metadata.boundingBox else {
            return
        }
        
        let items = response.collection.children.compactMap {
            if let point = $0.obj?.geometry.first?.point {
                return SearchResponseItem(point: point, geoObject: $0.obj)
            }
            return nil
        }
        makePlaceInfo(items)
      
           
    }
    
    func makePlaceInfo(_ items: [SearchResponseItem]){
        var places: [PlacePredictionInput] = []
        
        for item in items {
            let metadata = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
            let uris = item.geoObject?.metadataContainer.getItemOf(YMKUriObjectMetadata.self) as! YMKUriObjectMetadata
            let metadataPhoto = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessPhotoObjectMetadata.self) as? YMKSearchBusinessPhotoObjectMetadata
            var photos: [String?] = []
            if let photosMetadata = metadataPhoto?.photos {
                for photoMetadata in photosMetadata {
                    var photoData = String(photoMetadata.id.dropLast(2))
                    photoData += "XL"
                    photos.append(photoData)
                }
            }
            
            let categoryNames = metadata.categories.map { $0.name }
            if let matchingCategory = categoryNames.first(where: {AcceptablePlaceCategories.placeCategories.contains($0)}){
                for (names, values) in zip(metadata.features, metadata.features.map {$0.value.textValue}) {
                    if let name = names.name, name.contains("средний счёт"), let value = values {
                        cost = value.joined()
                        if let cost = cost{
                            averageBill = "Средний счёт \(cost)"
                        }
                    }
                }
                let features = getFeatures(from: metadata.features)
                var childrenRoom = (features["детская комната"] as? Bool) ?? false
                var wheelchair = ((features["доступность входа на инвалидной коляске"] as? [String]) == ["доступно"])
                var bills = convertBills(features["цены"])
                for venue in userFavouritePlaces{
                    let input = try VenueRecommenderInput(isChildFriendly: 0.7 * venue.isChildFriendly + 0.3 * (childrenRoom ? 1 : 0),
                                                          hasAlcohol: venue.hasAlcohol * 0,
                                                          wheelChairAccess: 0.7 * venue.wheelChairAccess + 0.3 * (wheelchair ? 1 : 0),
                                                          averageBill: 0.7 * venue.averageBill + 0.3 * Double(bills),
                                                          Bakery: 0.7 * venue.Bakery + 0.3 * (categoryNames.contains("Пекарня") ? 1 : 0),
                                                          CoffeeShop: 0.7 * venue.CoffeeShop + 0.3 * (categoryNames.contains("Кофейня") ? 1 : 0),
                                                          Pizzeria: 0.7 * venue.Pizzeria + 0.3 * (categoryNames.contains("Пиццерия") ? 1 : 0),
                                                          Cafe: 0.7 * venue.Cafe + 0.3 * (categoryNames.contains("Кафе") ? 1 : 0),
                                                          TakeawayCoffee: 0.7 * venue.TakeawayCoffee + 0.3 * (categoryNames.contains("Кофе с собой") ? 1 : 0),
                                                          TakeawayFood: 0.7 * venue.TakeawayFood + 0.3 * (categoryNames.contains("Еда на вынос") ? 1 : 0),
                                                          Food: 0.7 * venue.Food + 0.3 * (categoryNames.contains("Фудмолл, гастромаркет") ? 1 : 0),
                                                          Confectionery: 0.7 * venue.Confectionery + 0.3 * (categoryNames.contains("Кондитерская") ? 1 : 0),
                                                          IceCream: 0.7 * venue.IceCream + 0.3 * (categoryNames.contains("Мороженое") ? 1 : 0),
                                                          Bar: 0.7 * venue.Bar + 0.3 * (categoryNames.contains("Бар, паб") ? 1 : 0),
                                                          SushiBar: 0.7 * venue.SushiBar + 0.3 * (categoryNames.contains("Суши-бар") ? 1 : 0),
                                                          Restaurant: 0.7 * venue.Restaurant + 0.3 * (categoryNames.contains("Ресторан") ? 1 : 0),
                                                          TakeawayMeals: 0.7 * venue.TakeawayMeals + 0.3 * (categoryNames.contains("Еда с собой") ? 1 : 0),
                                                          Pub: 0/*0.7 * venue.Pub + 0.3 * (categoryNames.contains("Спортбар") ? 1 : 0)*/,
                                                          FastFood: 0.7 * venue.FastFood + 0.3 * (categoryNames.contains("Быстрое питание") ? 1 : 0),
                                                          Canteen: 0/*0.7 * venue.Canteen + 0.3 * (categoryNames.contains("Столовая") ? 1 : 0)*/)
                    
                    if let prediction = try? model?.prediction(input: input){
//                        print("input: ", input.isChildFriendly, input.hasAlcohol, input.wheelChairAccess, input.averageBill, input.Bakery, input.CoffeeShop, input.Pizzeria, input.Cafe, input.TakeawayCoffee, input.TakeawayFood, input.Food, input.Confectionery, input.IceCream, input.Bar, input.SushiBar, input.Restaurant, input.TakeawayMeals, input.Pub, input.FastFood, input.Canteen, prediction.likedByUser)
                        if prediction.likedByUser == 1{
                            let place = RecommendationsStruct(placeId: metadata.oid,
                                                              name: (item.geoObject?.name)!,
                                                              address: metadata.address.formattedAddress,
                                                              averageBill: averageBill,
                                                              categories: categoryNames)
                            print(place.name)
                            if !RecommendationEngine.recommendations.contains(where: {$0.placeId == place.placeId})
                            {
                                if (place.name != "Detilapshi"){
                                    RecommendationEngine.recommendations.append(RecommendationsStruct(placeId: metadata.oid,
                                                                                                      name: (item.geoObject?.name)!,
                                                                                                      address: metadata.address.formattedAddress,
                                                                                                      averageBill: averageBill,
                                                                                                      categories: categoryNames))
                                }
                            }
//                            print(item.geoObject?.name)
                        }
                    }
                }
            }
        }
    }
    
       
    }
    
    private func getFeatures(from features: [YMKSearchFeature]) -> [String: Any]{
        var result: [String: Any] = [:]
        for data in features{
            var value: Any? = nil
            if let textValue = data.value.textValue{
                value = textValue
            }
            else if let booleanValue = data.value.booleanValue?.value{
                value = booleanValue
            }
            else if let enumValue = data.value.enumValue.map({$0.map{$0.name}}){
                value = enumValue
            }
               if let name = data.name{
                       result[name] = value
            }
        }
            return result
        }

    private func convertBills(_ prices: Any) -> Int{
        var bills = 1
        if (prices as? [String]) == ["высокие"]{
            bills = 3
        }
        else if (prices as? [String]) == ["выше среднего"]{
            bills = 2
        }
        else if (prices as? [String]) == ["средние"]{
            bills = 1
        }
        else if (prices as? [String]) == ["низкие"]{
            bills = 0
        }
        return bills
    }
    
    
struct Venue {
    var name: String
    var isChildFriendly: Double
    var hasAlcohol: Double
    var wheelChairAccess: Double
    var averageBill: Double
    var Bakery: Double
    var CoffeeShop: Double
    var Pizzeria: Double
    var Cafe: Double
    var TakeawayCoffee: Double
    var TakeawayFood: Double
    var Food: Double
    var Confectionery: Double
    var IceCream: Double
    var Bar: Double
    var SushiBar: Double
    var Restaurant: Double
    var TakeawayMeals: Double
    var Pub: Double
    var FastFood: Double
    var Canteen: Double
}


struct RecommendationsStruct{
    var placeId: String
    var name: String
    var address: String
    var averageBill: String
    var categories: [String]
}
