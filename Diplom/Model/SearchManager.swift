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
        options.resultPageSize = 32
        return options
    }()
    
    var placeCategories = ["Кафе", "Пиццерия", "Столовая", "Ресторан", "Бар", "Паб", "Быстрое питание", "Суши-бар", "Кофейня", "Кондитерская", "Пекарня",  "Кофе с собой", "Еда на вынос", "Еда с собой", "Мороженое", "Бар", "Еда", ""]
    
    var averageBill = ""
    var placesResult: [Place] = []
    
    func search(completion: @escaping (([Place]) -> Void)){
        searchSession = searchManager.submit(
                   withText: SearchViewController.buttonText,
                   geometry: YMKGeometry(point: YMKPoint(latitude: SearchViewController.userLatitude!, longitude: SearchViewController.userLongtitude!)),
                   searchOptions: searchOptions,
                   responseHandler: { [weak self] response, error in
                       self!.handleSearchSessionResponse(response: response, error: error, completion: completion)
                   }
           )
    }
        
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?, completion: ([Place]) -> Void) {
        if let error = error {
            completion([])
            print("ERROR: ", error)
            return
            }

        guard let response = response,
              let boundingBox = response.metadata.boundingBox else {
            return
        }
        
        let tryResponse = response.collection.children
        let im: [UIImage] = []
        for item in tryResponse {
//            let metadata2 = item.getItemOf(YMKSearchPlaceInfo.self) as? YMKSearchPlaceInfo
//            im.append(item.image?.images)
//            print(item.image?.images)
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
            
            let metadata2 = item.geoObject?.metadataContainer.getItemOf(YMKSearchPlaceInfo.self) as? YMKSearchPlaceInfo
            print(metadata2)
            
            let categoryNames = metadata.categories.map { $0.name }

            if let matchingCategory = categoryNames.first(where: {placeCategories.contains($0)}){
                for (names, values) in zip(metadata.features, metadata.features.map {$0.value.textValue}) {
                    if let name = names.name, name.contains("средний счёт"), let value = values {
                        let cost = value.joined()
                        averageBill = "Средний счёт \(cost)"
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
