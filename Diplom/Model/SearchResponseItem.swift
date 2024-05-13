//
//  SearchResponseItem.swift
//  Diplom
//
//  Created by Margarita Usova on 31.03.2024.
//

import Foundation
import YandexMapsMobile

struct SearchResponseItem: Hashable {
    let point: YMKPoint
    let geoObject: YMKGeoObject?
}
