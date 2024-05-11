//
//  MapCameraListener.swift
//  Diplom
//
//  Created by Margarita Usova on 09.05.2024.
//

import Foundation
import YandexMapsMobile

class MapCameraListener: NSObject, YMKMapCameraListener {
    
    private let searchManager: SearchManager
    
    init(searchManager: SearchManager){
        self.searchManager = searchManager
    }
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        if cameraUpdateReason == .gestures{
            searchManager.setVisibleRegion(region: map.visibleRegion)
        }
    }
    
    
}
