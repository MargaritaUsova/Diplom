//
//  MapController.swift
//  Diplom
//
//  Created by Margarita Usova on 04.04.2024.
//

import Foundation
import YandexMapsMobile

class MapController{
    
    var map: YMKMap!
    static var mapView: YMKMapView!
    
    func mapConfigure(view: UIView){
        MapController.mapView = YMKMapView(frame: view.frame)
        map = MapController.mapView.mapWindow.map

        MapController.mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: SearchViewController.userLatitude!, longitude: SearchViewController.userLongtitude!),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
    }
    
    //добавление точек на карту
    
}
