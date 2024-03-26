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
}


func fetchAdditionalData(placeId: String){
    let myAPIKey = "5eb37259-8a84-4076-85ad-a7620b47bed6"
    let urlStringForReviews = "https://search-maps.yandex.ru/v1/places/\(placeId)/?apikey=\(myAPIKey)&fields=reviews"
    
}
