//
//  GeometryProvider.swift
//  Diplom
//
//  Created by Margarita Usova on 23.04.2024.
//

import Foundation
import YandexMapsMobile

enum GeometryProvider {
    static let clusterRadius: CGFloat = 10.0
    static let clusterMinZoom: UInt = 19

    static let startPoint = locationConstants.usersPosition
    static let startPosition = locationConstants.cameraPosition
    
    static var clusterizedPoints = SearchResultsViewController.placesData
}


