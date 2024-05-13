//
//  PlacesParser.swift
//  Diplom
//
//  Created by Margarita Usova on 11.05.2024.
//

import Foundation
import YandexMapsMobile


class PlacesParser{
    private var searchSession: YMKSearchSession?
    private var parsedData = Set<SearchResponseItem>()
    private var searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
    private let fileName = "ObjectsData"
    private var searchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        options.snippets = YMKSearchSnippet.photos
        options.resultPageSize = 3000
        return options
    }()
    
    let polygon: YMKPolygon = {
        var points = [
            YMKPoint(latitude: 41.1864, longitude: 19.6397),
            YMKPoint(latitude: 81.2504, longitude: 19.6397),
            YMKPoint(latitude: 81.2504, longitude: 180.0),
            YMKPoint(latitude: 41.1864, longitude: 180.0)
        ]
        points.append(points[0])
        let outerRing = YMKLinearRing(points: points)
        return YMKPolygon(outerRing: outerRing, innerRings: [])
    }()
    
    func search(){
        searchSession = searchManager.submit(
            withText: "where to eat",
            geometry:  YMKGeometry(polygon: polygon),
            searchOptions: searchOptions,
            responseHandler: handleSearchSessionResponse
        )
    }
    
    func writeData(toCSVFile filePath: String, data: [TrainingData]) {
        var csvString = ""

        if FileManager.default.fileExists(atPath: filePath) {
            do {
                csvString = try String(contentsOfFile: filePath, encoding: .utf8)
            } catch {
                print("Ошибка при чтении файла:", error)
                return
            }
        } else {
            csvString = "latitude,longtitude,id,uri,name,category,address,cuisines,priceClassification,workingHours,placeType,wheelchairAccess,specialMenu,childrenRoom,paymentMethod\n"
        }

        var newDataLines: [String] = []
        for item in data {
            let newLine = "\(item.latitude),\(item.longitude),\(item.id),\(item.uri),\(item.name),\(item.category.joined(separator: ";")),\(item.address),\(item.cuisines.joined(separator: ";")),\(item.priceClassification.joined(separator: ";")),\(item.workingHours ?? ""),\(item.placeType.joined(separator: ";")),\(item.wheelchairAccess),\(item.specialMenu.joined(separator: ";")),\(item.childrenRoom),\(item.paymentMethod.joined(separator: ";"))\n"

            if !csvString.contains(newLine) {
                newDataLines.append(newLine)
            }
        }
        csvString.append(contentsOf: newDataLines.joined())
        do {
            try csvString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("Данные успешно записаны в файл: \(filePath)")
        } catch {
            print("Ошибка при записи данных в файл: \(error)")
        }
    }


    func readDataFromCSVFile(filename: String) -> [TrainingData] {
        var data: [TrainingData] = []

        do {
            let contents = try String(contentsOfFile: filename, encoding: .utf8)
            let lines = contents.components(separatedBy: .newlines)
            let startIndex = lines.first?.contains("latitude") == true ? 1 : 0
            for line in lines[startIndex...] {
                guard !line.isEmpty else { continue }
                let columns = line.components(separatedBy: ",")
                guard columns.count >= 15 else {
                    print("Error: Invalid number of columns in line:", line)
                    continue
                }

                let latitude = Double(columns[0]) ?? 0.0
                let longitude = Double(columns[1]) ?? 0.0
                let id = columns[2]
                let uri = columns[3]
                let name = columns[4]
                let category = columns[5].components(separatedBy: ";")
                let address = columns[6]
                let cuisines = columns[7].components(separatedBy: ";")
                let priceClassification = columns[8].components(separatedBy: ";")
                let workingHours = columns[9]
                let placeType = columns[10].components(separatedBy: ";")
                let wheelchairAccess = Bool(columns[11]) ?? false
                let specialMenu = columns[12].components(separatedBy: ";")
                let childrenRoom = Bool(columns[13]) ?? false
                let paymentMethod = columns[14].components(separatedBy: ";")

                let newData = TrainingData(latitude: latitude,
                                            longitude: longitude,
                                            id: id,
                                            uri: uri,
                                            name: name,
                                            category: category,
                                            address: address,
                                            cuisines: cuisines,
                                            priceClassification: priceClassification,
                                            workingHours: workingHours,
                                            placeType: placeType,
                                            wheelchairAccess: wheelchairAccess,
                                            specialMenu: specialMenu,
                                            childrenRoom: childrenRoom,
                                            paymentMethod: paymentMethod)
                data.append(newData)
            }
        } catch {
            print("Error reading from file:", error)
        }

        return data
    }


    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error = error {
            print("Ошибка запроса при поиске: ", error)
            return
        }
        
        guard let response = response,
              let boundingBox = response.metadata.boundingBox else {
            return
        }
        
        let items = response.collection.children.compactMap {
            if let point = $0.obj?.geometry.first?.point {
                return SearchResponseItem(point: point, geoObject: $0.obj)
            }
            return nil
            
        }
        let placeItems = makePlaceInfoTrainingData(items)
    }
    
    func makePlaceInfoTrainingData(_ items: [SearchResponseItem]) -> [TrainingData]{
        var places: [TrainingData] = []
        print("items count", items.count)
        for item in items {
            let metadata = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
            
            let categoryNames = metadata.categories.map { $0.name }
            if let matchingCategory = categoryNames.first(where: {AcceptablePlaceCategories.placeCategories.contains($0)}){
                
                let uri = (item.geoObject?.metadataContainer.getItemOf(YMKUriObjectMetadata.self) as? YMKUriObjectMetadata)?.uris.first
                let features = getFeatures(from: metadata.features)

                
                if let uri = uri?.value as? String,
                   let name = item.geoObject?.name,
                   let cuisines =  features["кухня"] as? [String],
                   let priceClassification =  features["цены"] as? [String],
                   let placeType = features["тип заведения"] as? [String],
                   let wheelchairAccess = features["доступность входа на инвалидной коляске"] as? [String],
                   let specialMenu = features["специальное меню"] as? [String],
                   let childrenRoom = features["детская комната"] as? Bool,
                   let paymentMethod = features["способ оплаты"] as? [String]{
                    
                      let place = TrainingData(latitude: item.point.latitude,
                             longitude: item.point.longitude,
                             id: metadata.oid,
                             uri: uri,
                             name: name,
                             category: categoryNames,
                             address: metadata.address.formattedAddress,
                             cuisines: cuisines,
                             priceClassification: priceClassification,
                             workingHours: metadata.workingHours?.text,
                             placeType: placeType,
                             wheelchairAccess: wheelchairAccess==["доступно"],
                             specialMenu: specialMenu,
                             childrenRoom: childrenRoom,
                             paymentMethod: paymentMethod)
                
                        places.append(place)
                }
            }
            
        }
        print("places count: ", places.count)
        var placesFromCSV = readDataFromCSVFile(filename: "/Users/margaritausova/Documents/Diplom/Diplom/TrainingDataCSV.csv")
        print("read data ", placesFromCSV.count)
        let combinedArray = places + placesFromCSV
        let uniqueSet = Set(combinedArray)
        let newPlaces = Array(uniqueSet)
        writeData(toCSVFile: "/Users/margaritausova/Documents/Diplom/Diplom/TrainingDataCSV.csv", data: places)
        let amount = countTrainingDataInCSV(filename: "/Users/margaritausova/Documents/Diplom/Diplom/TrainingDataCSV.csv")
        print("amount: ", amount)
        return places
            
    }
    
    func countTrainingDataInCSV(filename: String) -> Int {
        var count = 0
        do {
            let contents = try String(contentsOfFile: filename, encoding: .utf8)
            let lines = contents.components(separatedBy: .newlines)
            for line in lines {
                if !line.isEmpty {
                    count += 1
                }
            }
        } catch {
            print("Ошибка чтения из файла: \(error)")
        }
        
        return count
    }


    
    private func getFeatures(from features: [YMKSearchFeature]) -> [String: Any]{
        var result: [String: Any] = [:]
        for data in features{
            var value: Any? = nil
            if let textValue = data.value.textValue{
                value = textValue
            }
            else if let booleanValue = data.value.booleanValue?.value{
                value = booleanValue
            }
            else if let enumValue = data.value.enumValue.map({$0.map{$0.name}}){
                value = enumValue
            }
            if let name = data.name as? String,
                let value = value
               {
                result[name] = value
            }
        }
        return result
    }
    



    
}

class GetParserData{
    let parser = PlacesParser()
    let csvFilePath = "/Users/margaritausova/Documents/Diplom/Diplom/TrainingDataCSV.csv"
    init(){
        
    }
}


