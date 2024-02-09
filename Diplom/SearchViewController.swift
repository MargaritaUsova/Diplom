//
//  ViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 31.01.2024.
//

import UIKit
import YandexMapsMobile

class SearchViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerForKeyboardNotifications()

        
        /*
        let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
        
        let mapView = YMKMapView(frame: view.frame)
                view.addSubview(mapView)

        let map = mapView.mapWindow.map
        
        let searchOptions: YMKSearchOptions = {
            let options = YMKSearchOptions()
            options.searchTypes = .biz
            options.resultPageSize = 32
            return options
        }()

        
        let searchSession = searchManager.submit(
                        withText: "Restaurant",
                        geometry: YMKVisibleRegionUtils.toPolygon(with: map.visibleRegion),
                        searchOptions: searchOptions,
                        responseHandler: handleSearchSessionResponse
                    )
        
        
        
        let cameraCallback: YMKMapCameraCallback = { isFinished in
            // Handle camera movement completion
        }

        map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: 59.935493, longitude: 30.327392),
                zoom: 13.0,
                azimuth: .zero,
                tilt: .zero
            ),
            animationType: YMKAnimation(type: .linear, duration: 1.0),
            cameraCallback: cameraCallback
        )

        
        
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error {
            // Handle search error
            return
        }
        
        // Handle search response
        let items = response!.collection.children.compactMap {
            if let point = $0.obj?.geometry.first?.point {
                print(point)

                
            }
        }*/
    }
    
    
    // обработка появления последних строк меню при открытой клавиатуре
    func registerForKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWasShown(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
            NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillBeHidden(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        }
    
        @objc func keyboardWasShown(_ notificiation: NSNotification) {
            guard let info = notificiation.userInfo,
                let keyboardFrameValue =
                info[UIResponder.keyboardFrameBeginUserInfoKey]
                as? NSValue else { return }
     
            let keyboardFrame = keyboardFrameValue.cgRectValue
            let keyboardSize = keyboardFrame.size
     
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
            bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
     
        @objc func keyboardWillBeHidden(_ notification:
           NSNotification) {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
   

}

