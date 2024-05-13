//
//  SearchResultsFloatingViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 17.03.2024.
//
import UIKit

class SearchResultsFloatingViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    static let shared = SearchResultsFloatingViewController()
    var selectedIndex: IndexPath = [0,0]
    private let searchManager = SearchManager()
    
    static let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "PlaceInfoCell", bundle: nil), forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SearchResultsViewController.placesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PlaceInfoCell
        cell.address.text = SearchResultsViewController.placesData[indexPath.row].address
        cell.categoriesList.text = SearchResultsViewController.placesData[indexPath.row].category.joined(separator: ",")
        cell.placeName.text = SearchResultsViewController.placesData[indexPath.row].name
        cell.selectedPlace = SearchResultsViewController.placesData[indexPath.row]
        cell.selectedPlaceId = SearchResultsViewController.placesData[indexPath.row].id
        cell.averageBill.text = SearchResultsViewController.placesData[indexPath.row].averageBill
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let placeInfoVC = mainStoryboard.instantiateViewController(identifier: "PlaceInfoVC") as! PlaceInfoViewController
        placeInfoVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        placeInfoVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        placeInfoVC.placesInfo = SearchResultsViewController.placesData
        placeInfoVC.selectedIndex = indexPath
        self.present(placeInfoVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        self.title = "Список мест"
        view.layer.cornerRadius = 30
       
        SearchResultsFloatingViewController.tableView.delegate = self
        SearchResultsFloatingViewController.tableView.dataSource = self
        
        setUpTableView()
              
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SearchResultsFloatingViewController.tableView.reloadData()
    }
    
    
    func setUpTableView(){
        view.addSubview(SearchResultsFloatingViewController.tableView)
        SearchResultsFloatingViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            SearchResultsFloatingViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            SearchResultsFloatingViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            SearchResultsFloatingViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            SearchResultsFloatingViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    }
    

}

