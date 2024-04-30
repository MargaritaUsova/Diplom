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

    static let startPoint = YMKPoint(latitude: LocationManager.shared.userLatitude, longitude: LocationManager.shared.userLongtitude)
    static let startPosition = YMKCameraPosition(target: startPoint, zoom: 8.0, azimuth: .zero, tilt: .zero)

    static let clusterizedPoints = SearchResultsViewController.placesData
}


