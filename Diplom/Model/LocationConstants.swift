//
//  LocationConstants.swift
//  Diplom
//
//  Created by Margarita Usova on 10.05.2024.
//

import Foundation
import YandexMapsMobile

enum locationConstants {
    static let usersPosition = YMKPoint(latitude: LocationManager.userLatitude, longitude: LocationManager.userLongtitude)
    static let cameraPosition = YMKCameraPosition(target: usersPosition, zoom: 15, azimuth: .zero, tilt: .zero)
}
