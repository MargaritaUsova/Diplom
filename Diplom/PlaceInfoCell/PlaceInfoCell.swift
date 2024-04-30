//
//  PlaceInfoCell.swift
//  Diplom
//
//  Created by Margarita Usova on 06.04.2024.
//

import Foundation
import UIKit
import CoreData

class PlaceInfoCell: UITableViewCell{
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var categoriesList: UILabel!
    @IBOutlet weak var averageBill: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var toFavouritesButton: UIButton!
    var selectedPlace: Place!
    var selectedPlaceId: String!
    var like = false
    static var favouritePlaces = [NSManagedObject]()
    

    @IBAction func toFavouritesButtonAction(_ sender: Any) {
        let date = Date()
        
        if toFavouritesButton.currentImage == UIImage(systemName: "heart.fill"){
            FavouritePlacesDBManager().deleteFavouritePlace(with: selectedPlaceId)
            toFavouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            FavoritesViewController().favouritePlaces = FavoritesViewController().favouritePlaces.filter {
                $0.placeId != selectedPlaceId
            }
            
        }
        else {
            PlaceInfoCell.favouritePlaces = FavouritePlacesDBManager().addFavouritePlaces(place: selectedPlace, dateAdded: date)
            toFavouritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        FavoritesViewController.tableView.reloadData()
    }
    
    func configureCellButton(placeId: String?) -> Bool{
        guard let placeId = placeId else {
            toFavouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            return false
        }
        let favouritePlacesChecker = checkIfPlaceIsFavourite(with: placeId)
        toFavouritesButton.setImage(favouritePlacesChecker ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        return favouritePlacesChecker
    }
    
    func checkIfPlaceIsFavourite(with id: String?) -> Bool{
        let fetchedDataFromDB = FavouritePlacesDBManager().fetchFavouritePlaces()
        for place in fetchedDataFromDB{
            if place.placeId == id {
                return true
            }
        }
        return false
    }
    
    
    
    
}
