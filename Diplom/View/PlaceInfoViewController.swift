//
//  PlaceInfoViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 07.04.2024.
//

import UIKit

class PlaceInfoViewController: UIViewController {
    var placesInfo: [Place] = []
    var favouritePlacesInfo: [FavouritePlacesDB] = []
    var selectedIndex: IndexPath = [0,0]
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placePhoneNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if placesInfo.isEmpty{
            placeName.text = favouritePlacesInfo[selectedIndex.row].name
            placePhoneNumber.text = "+7-123-987-45-56"
           
        }
        else{
            placeName.text = placesInfo[selectedIndex.row].name
            placePhoneNumber.text = placesInfo[selectedIndex.row].phoneNumbers?.joined(separator: ",")
        }
    }
    
}
