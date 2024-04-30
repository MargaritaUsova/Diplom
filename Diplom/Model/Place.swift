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
    var classification: String?
}


func getPlaceClassification(_ places: [Place]) {
    var averageBill:[String?] = []
    for place in places{
        averageBill.append(place.averageBill)
    }
    var maxPrice: [Int] = []
    var minPrice: [Int] = []
    var prices: [(Int, Int)] = []
    for averageBill in averageBill {
        if let averageBill = averageBill  {
            
            if let indexSeparator = averageBill.firstIndex(of: "–") {
                minPrice.append(Int(averageBill[..<indexSeparator])!)
                let startIndexMax = averageBill.index(after: indexSeparator)
                let endIndexMax = averageBill.firstIndex(of: " ")
                maxPrice.append(Int(averageBill[startIndexMax..<endIndexMax!])!)
                prices.append((Int(averageBill[..<indexSeparator])!, Int(averageBill[startIndexMax..<endIndexMax!])!))
            }
            else {
                if let indexSeparator = averageBill.firstIndex(of: " "){
                    let startIndexAverage = averageBill.index(after: indexSeparator)
                    let endIndexAverage = averageBill.lastIndex(of: " ")
                    minPrice.append(Int(averageBill[startIndexAverage..<endIndexAverage!])!)
                }
            }
            var max = 0
            for price in maxPrice {
                max += price
            }
            var min = 0
            for price in minPrice {
                min += price
            }
            let averageCost = (max + min) / (maxPrice.count + minPrice.count)
            print(averageCost)
        }
    }
    
}




