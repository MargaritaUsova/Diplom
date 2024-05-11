//
//  SearchResultsViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 21.02.2024.
//

import UIKit
import YandexMapsMobile

class SearchResultsViewController: UIViewController {
    static var floatingVC: UIViewController!
    static var placesData = [Place]()
    @IBOutlet weak var backToSearchViewControllrtButton: UIButton!
    static var shared: UIViewController!
    private let searchManager = SearchManager()
    private let mapController = MapController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapController.searchResultsVC = self
        MapController.mapObjectTapListener = MapObjectTapListener(controller: self)
        mapController.mapConfigure(self.view, searchResultsVC: self)
        
        self.view.addSubview(mapController.mapView)
        mapController.setupStateUpdates()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubviewToFront(self.backToSearchViewControllrtButton)
        self.presentModal()
        
    }
    
    
    @IBAction func backToSearchVCAction(_ sender: Any) {
        if let presentingViewController = presentingViewController{
            presentingViewController.dismiss(animated: true)
        }
        
    }
    
    
    func presentModal(){
        SearchResultsViewController.floatingVC = SearchResultsFloatingViewController()
        let nav = UINavigationController(rootViewController: SearchResultsViewController.floatingVC)
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        
          if let sheet = nav.sheetPresentationController {
              sheet.detents = [.medium(), .large(), .custom(resolver:{ content in
                  0.1 * content.maximumDetentValue})]
              sheet.prefersScrollingExpandsWhenScrolledToEdge = false
              sheet.largestUndimmedDetentIdentifier = .large
          }
//       
        self.present(nav, animated: true, completion: nil)

        
    }

                
}
