//
//  TrainingData.swift
//  Diplom
//
//  Created by Margarita Usova on 12.05.2024.
//

import Foundation
import YandexMapsMobile

struct TrainingData: Hashable{
    let latitude: Double
    let longitude: Double
    let id: String
    let uri: String
    let name: String
    let category: [String]
    let address: String
    let cuisines: [String]
    let priceClassification: [String]
    let workingHours: String?
    let placeType: [String]
    let wheelchairAccess: Bool
    let specialMenu: [String]
    let childrenRoom: Bool
    let paymentMethod: [String]
    func hash(into hasher: inout Hasher) {
            hasher.combine(latitude)
            hasher.combine(longitude)
            hasher.combine(id)
        }

        // Реализация метода == для проверки равенства двух экземпляров TrainingData
        static func == (lhs: TrainingData, rhs: TrainingData) -> Bool {
            return lhs.latitude == rhs.latitude &&
                lhs.longitude == rhs.longitude &&
                lhs.id == rhs.id
            
        }
}
