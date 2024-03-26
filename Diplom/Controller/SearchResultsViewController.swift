//
//  SearchResultsViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 21.02.2024.
//

import UIKit
import YandexMapsMobile

class SearchResultsViewController: UIViewController {
    var buttonText: String?
    var latitude, longitude: Double!
    
    let floatingVC = SearchResultsFloatingViewController()
    
    var searchSession: YMKSearchSession!
    var searchOptions: YMKSearchOptions!
    var searchManager: YMKSearchManager!
    
    var map: YMKMap!
    var mapView: YMKMapView!
    
    var places: [Place] = []
    var placeCategories = ["Кафе", "Пиццерия", "Столовая", "Ресторан", "Бар", "Паб", "Быстрое питание", "Суши-бар", "Кофейня", "Кондитерская", "Пекарня",  "Кофе с собой", "Еда на вынос", "Еда с собой", "Мороженое", "Бар", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        tabBarController?.tabBar.isHidden = true
       
        
        searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)

        mapView = YMKMapView(frame: view.frame)
        map = mapView.mapWindow.map
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: latitude, longitude: longitude),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
        
        view.addSubview(mapView)
    
        searchOptions = {
            let options = YMKSearchOptions()
            options.searchTypes = .biz
            return options
        }()
        search()
        
        presentModal()
        
        
    }
    
    private func presentModal(){
        let floatinfVC = SearchResultsFloatingViewController()
        let nav = UINavigationController(rootViewController: floatinfVC)
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        
          if let sheet = nav.sheetPresentationController {
              sheet.detents = [.medium(), .large(), .custom(resolver:{ content in
                  0.1 * content.maximumDetentValue})]
              sheet.prefersScrollingExpandsWhenScrolledToEdge = false
              sheet.largestUndimmedDetentIdentifier = .large
          }
        present(nav, animated: true, completion: nil)
    }
    

    
    private func search(){
        searchSession = searchManager.submit(
            withText: buttonText!,
            geometry: YMKGeometry(point: YMKPoint(latitude: latitude, longitude: longitude)),
            searchOptions: searchOptions,
            responseHandler: handleSearchSessionResponse
        )
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error = error {
            print("ERROR: ", error)
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
        
        for item in items {
        
            var metadata = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
            
            let categoryNames = metadata.categories.map { $0.name }
                
                if let matchingCategory = categoryNames.first(where: {placeCategories.contains($0)}){
                    let place = Place(point: item.point, geoObject: item.geoObject, name: item.geoObject!.name!, category: categoryNames, address: metadata.address.formattedAddress, id: metadata.oid)
                    print(metadata.oid)
                    places.append(place)
                    print(place.point, place.geoObject, place.name, place.category, place.address)
                    fetchAdditionalData(placeId: place.id)
               
            }
            
            var pinsCollection = map.mapObjects.add()
            
            var clusterListener = ClusterListener(controller: self)
            var clusterizedCollection = pinsCollection.addClusterizedPlacemarkCollection(with: clusterListener)
            
//            GeometryProvider??

                       
            for (index, place) in places.enumerated() {
                

//                pinsCollection.addPlacemark(with: place.point).setTextWithText(place.name)
               // нужен кластер https://yandex.ru/dev/mapkit/doc/ru/ios/generated/tutorials/map_objects
            }
        }
    }
    
    struct SearchResponseItem {
        let point: YMKPoint
        let geoObject: YMKGeoObject?
    }
    
}
