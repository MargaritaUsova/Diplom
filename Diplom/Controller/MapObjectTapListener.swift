//
//  MapObjectTapListener.swift
//  Diplom
//
//  Created by Margarita Usova on 29.04.2024.
//

import Foundation
import UIKit
import YandexMapsMobile

class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
    
    var controller: UIViewController?
    private var placeInfoVC: PlaceInfoViewController?
   
    
    init(controller: UIViewController) {
         self.controller = controller
         
     }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let userData = mapObject.userData as? PlacemarkUserData{
            MapController.indexPath = [0, userData.index]
        }
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let placeInfoVC = mainStoryboard.instantiateViewController(identifier: "PlaceInfoVC") as! PlaceInfoViewController
        
        placeInfoVC.modalPresentationStyle = .pageSheet
        placeInfoVC.modalTransitionStyle = .coverVertical
        placeInfoVC.placesInfo = SearchResultsViewController.placesData
        placeInfoVC.selectedIndex = MapController.indexPath
        SearchResultsViewController.floatingVC.present(placeInfoVC, animated: true, completion: nil)
        return true
    }
    
}
