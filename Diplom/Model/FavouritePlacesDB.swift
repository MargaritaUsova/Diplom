//
//  FavouritePlacesDB.swift
//  Diplom
//
//  Created by Margarita Usova on 17.04.2024.
//

import Foundation
import CoreData
import UIKit

class FavouritePlacesDBManager: NSObject, NSFetchedResultsControllerDelegate {
    var favouritePlacesDB: [NSManagedObject] = []
    var fetchRequest = NSFetchRequest<FavouritePlacesDB>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favouritePlacesId: [String] = []
    
    
    public func fetchFavouritePlaces() -> [FavouritePlacesDB]{
        fetchRequest = FavouritePlacesDB.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        
        var favouritePlaces: [FavouritePlacesDB] = []
        
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                if  !favouritePlacesId.contains(object.placeId!) {
                    favouritePlaces.append(object)
                    favouritePlacesId.insert(object.placeId!, at: 0)
                }
            }
        }
        
        catch let error as NSError {
            print("Ошибка получения данных из базы данных \(error)")
        }
        
        let persistentContainer = appDelegate.persistentContainer
        if let storeURL = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
//            print("Путь к файлу SQLite базы данных: \(storeURL)")
        }
        return favouritePlaces
    }
    
    
    public func deleteFavouritePlace(with placeId: String) {
        fetchRequest = FavouritePlacesDB.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects{
                if object.placeId == placeId {
                    context.delete(object)
                }
            }
            try context.save()
        }
        catch let error as NSError{
            print("Не удалось удалить значение с id \(placeId) из базы данных, \(error)")
        }
    }
    
    public func deleteAllData(){
        fetchRequest = FavouritePlacesDB.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects{
                context.delete(object)
            }
            try context.save()
        }
        catch let error as NSError{
            print("Не удалось удалить значения из базы данных, \(error)")
        }
    }
    
    
    public func addFavouritePlaces(place: Place, dateAdded: Date) -> [NSManagedObject] {
        var favouritePlaces = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let favouritePlacesDBEntity = NSEntityDescription.entity(forEntityName: "FavouritePlacesDB", in: context)!
        let placeToAdd = NSManagedObject(entity: favouritePlacesDBEntity, insertInto: context)
        placeToAdd.setValue(place.name, forKey: "name")
        placeToAdd.setValue(dateAdded, forKey: "dateAdded")
        placeToAdd.setValue(place.id, forKey: "placeId")
        
        do {
            try context.save()
            favouritePlaces.append(placeToAdd)
        }
        catch let error as NSError {
            print("Невозможно сохранить в базу данных. \(error), \(error.userInfo)")
        }
        return favouritePlaces
    }
    
    
}

