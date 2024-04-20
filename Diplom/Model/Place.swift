//
//  SearchResultModel.swift
//  Diplom
//
//  Created by Margarita Usova on 03.03.2024.
//

import Foundation
import YandexMapsMobile

struct Place {
    let point: YMKPoint
    let geoObject: YMKGeoObject?
    let name: String
    let category: [String]
    var address: String?
    var id: String
    var phoneNumbers: [String]?
    var features: [String]?
    var links: [String]?
    var averageBill: String?
    var workingHours: String?
    var uri: String?
}



