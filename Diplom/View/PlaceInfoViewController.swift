//
//  PlaceInfoViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 07.04.2024.
//

import UIKit

class PlaceInfoViewController: UIViewController {
    var placesInfo: [Place] = []
    var selectedIndex: IndexPath = [0,0]
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placePhoneNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeName.text = placesInfo[selectedIndex.row].name
        placePhoneNumber.text = placesInfo[selectedIndex.row].phoneNumbers?.joined(separator: ",")
     
    }
    
}
