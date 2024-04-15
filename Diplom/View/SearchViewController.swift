//
//  ViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 31.01.2024.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class SearchViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var menuButton: [UIButton]!
    
    @IBOutlet var stackViewsCollection: [UIStackView]!

    @IBOutlet var menuCollection: [UIView]!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let locationManager = CLLocationManager()
    
    static var userLatitude, userLongtitude: Double?
    static var buttonText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        makeConstraintsForSearchViewController()
        getUserLocation()
        registerForKeyboardNotifications()
        searchBar.delegate = self

    }
    
    func makeConstraintsForSearchViewController(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant:  60)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        for button in menuButton {
            button.widthAnchor.constraint(equalToConstant: 111).isActive = true
            button.heightAnchor.constraint(equalToConstant: 111).isActive = true
        }
        // Устанавливаем констрейнты для stack view
        for (stackView, menuView) in zip(stackViewsCollection, menuCollection) {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 0),
                stackView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 0),
                stackView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 0),
                stackView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: 0)
            ])
        }
    }
    
    
    // обработка появления последних строк меню при открытой клавиатуре
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    private func getUserLocation(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.first {
            SearchViewController.userLatitude = location.coordinate.latitude
            SearchViewController.userLongtitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Got error: ", error)
        if (SearchViewController.userLatitude == nil || SearchViewController.userLongtitude == nil)
        {
            SearchViewController.userLatitude = 55.7558
            SearchViewController.userLongtitude = 37.6173
        }
    }
    
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        SearchViewController.buttonText = sender.titleLabel!.text!
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultsViewController = storyboard.instantiateViewController(identifier: "SearchResultsViewController")
        self.present(searchResultsViewController, animated: true)
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        searchBar.text = ""
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            print("Введенный запрос: ", searchText)
        }
    }
}
