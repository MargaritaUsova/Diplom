//
//  SearchManager.swift
//  Diplom
//
//  Created by Margarita Usova on 31.03.2024.
//

import Foundation
import YandexMapsMobile

class SearchManager{
    
    static let shared = SearchManager()
    var searchSession: YMKSearchSession?
    var searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    var searchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        return options
    }()
    
    var placeCategories = ["Кафе", "Пиццерия", "Столовая", "Ресторан", "Бар", "Паб", "Быстрое питание", "Суши-бар", "Кофейня", "Кондитерская", "Пекарня",  "Кофе с собой", "Еда на вынос", "Еда с собой", "Мороженое", "Бар", "Еда", ""]
    
    var averageBill = ""
    var placesResult: [Place] = []
    private var cost: String?
    
    func searchByCuisineType(completion: @escaping (([Place]) -> Void)){
        searchSession = searchManager.submit(
                   withText: SearchViewController.buttonText,
                   geometry: YMKGeometry(point: YMKPoint(latitude: LocationManager.shared.userLatitude, longitude: LocationManager.shared.userLongtitude)),
                   searchOptions: searchOptions,
                   responseHandler: { [weak self] response, error in
                       self!.handleSearchSessionResponse(response: response, error: error, completion: completion)
                   }
           )
    }
    
    func searchByUserQuery(){
        
    }
    
        
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?, completion: ([Place]) -> Void) {
        if let error = error {
            completion([])
            print("Ошибка запроса при поиске: ", error)
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
        
        placesResult = makePlaceInfo(items)
        completion(placesResult)
        
    }
        
    struct SearchResponseItem {
        let point: YMKPoint
        let geoObject: YMKGeoObject?
    }
            
    
    func makePlaceInfo(_ items: [SearchResponseItem]) -> [Place]{
        var places: [Place] = []
        
        for item in items {
            let metadata = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
            
            let categoryNames = metadata.categories.map { $0.name }

            if let matchingCategory = categoryNames.first(where: {placeCategories.contains($0)}){
                for (names, values) in zip(metadata.features, metadata.features.map {$0.value.textValue}) {
                    if let name = names.name, name.contains("средний счёт"), let value = values {
                        cost = value.joined()
                        if let cost = cost{
                            averageBill = "Средний счёт \(cost)"
                        }
                    }
                }
                let place = Place(point: item.point, 
                                  geoObject: item.geoObject,
                                  name: item.geoObject!.name!,
                                  category: categoryNames,
                                  address: metadata.address.formattedAddress,
                                  id: metadata.oid, 
                                  phoneNumbers: metadata.phones.map {$0.formattedNumber},
                                  features: metadata.features.map {$0.name ?? ""}, 
                                  links: metadata.links.map {$0.link.href},
                                  averageBill: averageBill,
                                  workingHours: metadata.workingHours?.text)
                    places.append(place)
               
            }
        }
        
        return places
    }
}
