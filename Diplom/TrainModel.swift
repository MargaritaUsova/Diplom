////
////  TrainModel.swift
////  Diplom
////
////  Created by Margarita Usova on 30.05.2024.
////
//
//import Foundation
//import CreateML
//
//class TrainModel{
//    func createModel(){
//        do{
//            let dataURL = Bundle.main.url(forResource: "generated_data", withExtension: "csv")!
//            let dataTable = try MLDataTable(contentsOf: dataURL)
//            let (trainingData, testingData) = dataTable.randomSplit(by: 0.8, seed: 5)
//
//            let classifier = try MLLogisticRegressionClassifier(trainingData: trainingData, targetColumn: "likedByUser")
//
//            let evaluationMetrics = classifier.evaluation(on: testingData)
//            print("Accuracy: \(evaluationMetrics)")
//
//            let trainingAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
//            print("Training accuracy: \(trainingAccuracy)%")
//            
//            let modelMetadata = MLModelMetadata(author: "Margarita Usova",
//                                                shortDescription: "A model to recommend restaurants based on user preferences.",
//                                                version: "1.0")
//            
//            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//               let modelURL = documentsURL.appendingPathComponent("RestaurantClassifier.mlmodel")
//
//               print("Saving model to: \(modelURL)")
//
//               try classifier.write(to: modelURL)
//
//               print("Model saved successfully!")
//        }
//        catch{
//            print("error while creating ml model ", error)
//        }
//    }
//}
