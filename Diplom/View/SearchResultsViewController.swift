//
//  SearchResultsViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 21.02.2024.
//

import UIKit
import YandexMapsMobile

class SearchResultsViewController: UIViewController {
    private let floatingVC = SearchResultsFloatingViewController()
    
    @IBOutlet weak var backToSearchViewControllrtButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapController = MapController()
        mapController.mapConfigure(view: view)
        view.addSubview(MapController.mapView)
        view.bringSubviewToFront(backToSearchViewControllrtButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentModal()
    }
    
    
    @IBAction func backToSearchVCAction(_ sender: Any) {
        if let presentingViewController = presentingViewController{
            presentingViewController.dismiss(animated: true)
        }
        
    }
    
    func presentModal(){
        let nav = UINavigationController(rootViewController: floatingVC)
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        
          if let sheet = nav.sheetPresentationController {
              sheet.detents = [.medium(), .large(), .custom(resolver:{ content in
                  0.1 * content.maximumDetentValue})]
              sheet.prefersScrollingExpandsWhenScrolledToEdge = false
              sheet.largestUndimmedDetentIdentifier = .large
          }
        present(nav, animated: true, completion: nil)

        
    }

                
}
    

