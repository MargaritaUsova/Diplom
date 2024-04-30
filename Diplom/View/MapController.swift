//
//  MapController.swift
//  Diplom
//
//  Created by Margarita Usova on 04.04.2024.
//

import Foundation
import YandexMapsMobile

class MapController  {
    private var map: YMKMap!
    var mapView: YMKMapView!
    private var pinsCollection: YMKMapObjectCollection?
    static var mapObjectTapListener: MapObjectTapListener!
    static var indexPath = IndexPath()
    
    func mapConfigure(_ view: UIView, searchResultsVC: UIViewController){
        mapView = YMKMapView(frame: view.frame)
        map = mapView.mapWindow.map
        LocationManager.shared.requestLocationAuthorization()
        LocationManager.shared.startUpdatingLocation()
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: LocationManager.shared.userLatitude, longitude: LocationManager.shared.userLongtitude),
                zoom: 15,
                azimuth: .zero,
                tilt: .zero
            ),
            animationType: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: nil)
        pinsCollection = map.mapObjects.add()
        addClusterizablePlacemarks(searchResultsVC)
    }
    
    
    private func addClusterizablePlacemarks(_ searchResultsVC: UIViewController) {
        
    var clusterListener = ClusterListener(controller: searchResultsVC)
        
        let clusterizedCollection = pinsCollection!.addClusterizedPlacemarkCollection(with: clusterListener)
        
        let iconStyle = YMKIconStyle()
        iconStyle.anchor = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        iconStyle.scale = 0.8

        GeometryProvider.clusterizedPoints!.enumerated().forEach { pair in
           
            let point = pair.element.point

            let type = PlacemarkType.random
            let image = type.image

            let placemark = clusterizedCollection.addPlacemark(with: point)
            placemark.geometry = point
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

    static var random: Self {
        [.green, .yellow, .red].randomElement() ?? .green
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

