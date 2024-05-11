//
//  MapController.swift
//  Diplom
//
//  Created by Margarita Usova on 04.04.2024.
//

import Foundation
import YandexMapsMobile
import Combine

class MapController  {
    var map: YMKMap!
    var mapView: YMKMapView!
    private var pinsCollection: YMKMapObjectCollection?
    static var mapObjectTapListener: MapObjectTapListener!
    private var searchManager = SearchManager()
    private let searchViewController = SearchViewController()
    var searchResultsVC: UIViewController?
    private lazy var mapCameraListener = MapCameraListener(searchManager: searchManager)
    static var indexPath = IndexPath()
    private var locationManager = LocationManager()
    private var subscriptions = Set<AnyCancellable>()
    
    func mapConfigure(_ view: UIView, searchResultsVC: UIViewController){
        mapView = YMKMapView(frame: view.frame)
        map = mapView.mapWindow.map
        
        locationManager.requestLocationAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.mapWindow.map.move(
            with: locationConstants.cameraPosition,
            animation: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: nil)
        searchManager.setVisibleRegion(region: map.visibleRegion)
        map.addCameraListener(with: mapCameraListener)
        
        pinsCollection = map.mapObjects.add()
        addClusterizablePlacemarks()
        searchManager.search(with: SearchViewController.queryText)
        searchManager.setupSubscriptions()
    }
    

    
    func setupStateUpdates() {
        searchManager.$mapState.sink { [weak self] state in
            let searchText = state?.searchText ?? String()
            self?.searchViewController.searchBar.text = searchText
            if case let .success(items, false, itemsBoundingBox) = state?.searchState {
                self?.displaySearchResults(items: self?.searchManager.makePlaceInfo(items), zoomToItems: false, itemsBoundingBox: itemsBoundingBox)
            }
        }
        .store(in: &subscriptions)
    }
    
    private func displaySearchResults(
        items: [Place]?,
        zoomToItems: Bool,
        itemsBoundingBox: YMKBoundingBox
    ) {
        map.mapObjects.clear()
        guard let items = items else {
            return
        }

//        items.forEach { item in
//            let image = UIImage(systemName: "circle.circle.fill")!
//                .withTintColor(.tintColor)
//
//            let placemark = map.mapObjects.addPlacemark()
//            placemark.geometry = item.point!
//            placemark.setViewWithView(YRTViewProvider(uiView: UIImageView(image: image)))
//
//            placemark.userData = item.geoObject
//            placemark.addTapListener(with: MapController.mapObjectTapListener)
//        }
        let iconStyle = YMKIconStyle()
        iconStyle.anchor = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        iconStyle.scale = 0.8

        SearchResultsViewController.placesData.enumerated().forEach { pair in
           
            let point = pair.element.point
            var prices: [String] = []
            if let featurePrices = pair.element.features?["цены"] as? [String]{
                prices = featurePrices
            }
            
            let type = PlacemarkType.choosePlaceColor(prices)
            let image = type.image

            let placemark = map.mapObjects.addPlacemark(with: point!)
            placemark.geometry = point!
            placemark.setIconWith(image, style: iconStyle)

            placemark.isDraggable = false
            placemark.userData = PlacemarkUserData(name: pair.element.name, index: pair.offset)
            placemark.addTapListener(with: MapController.mapObjectTapListener)
           
        }
        SearchResultsFloatingViewController.tableView.reloadData()
    }
    
    
    private func addClusterizablePlacemarks() {
        
        var clusterListener = ClusterListener(controller: searchViewController)
        let clusterizedCollection = pinsCollection!.addClusterizedPlacemarkCollection(with: clusterListener)
        
        let iconStyle = YMKIconStyle()
        iconStyle.anchor = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        iconStyle.scale = 0.8

        
        SearchResultsViewController.placesData.enumerated().forEach { pair in
           
            let point = pair.element.point
            var prices: [String] = []
            if let featurePrices = pair.element.features?["цены"] as? [String]{
                prices = featurePrices
            }
            
            let type = PlacemarkType.choosePlaceColor(prices)
            let image = type.image

            let placemark = clusterizedCollection.addPlacemark(with: point!)
            placemark.geometry = point!
            placemark.setIconWith(image, style: iconStyle)

            placemark.isDraggable = false
            placemark.userData = PlacemarkUserData(name: pair.element.name, index: pair.offset)
            placemark.addTapListener(with: MapController.mapObjectTapListener)
           
        }

        clusterizedCollection.clusterPlacemarks(
            withClusterRadius: GeometryProvider.clusterRadius,
            minZoom: GeometryProvider.clusterMinZoom
        )
    }
}
enum PlacemarkType: CaseIterable {
    case green
    case yellow
    case red

    static func choosePlaceColor(_ prices: [String]) -> Self{
        if prices.contains("низкие") || prices.contains("средние"){
            return .green
        }
        else if prices.contains("выше среднего"){
            return .yellow
        }
        else if prices.contains("высокие"){
            return .red
        }
        else{
            return .green
        }
    }

    var image: UIImage {
        switch self {
        case .green:
            return UIImage(named: "pin_green")!

        case .yellow:
            return UIImage(named: "pin_yellow")!

        case .red:
            return UIImage(named: "pin_red")!
        }
    }
}

