//
//  PrepareModel.swift
//  Diplom
//
//  Created by Margarita Usova on 02.06.2024.
//

import Foundation
//import CoreML

// Загрузка модели из файла pickle
import CoreML

let modelURL = Bundle.main.url(forResource: "knn_model", withExtension: "onnx")!
let compiledModelURL = try? MLModel.compileModel(at: modelURL)

let coreMLModel = try? MLModel(contentsOf: compiledModelURL!)


// Преобразование модели k-ближайших соседей в Core ML модель
//let coreMLModel = try! KNearestNeighborsClassifier(configuration: MLModelConfiguration(), model: knnModel)

// Использование coreMLModel в вашем приложении
// Добавьте код для использования coreMLModel здесь
