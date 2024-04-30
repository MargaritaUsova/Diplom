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
    var placesData = SearchResultsViewController.placesData!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "PlaceInfoCell", bundle: nil), forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PlaceInfoCell
        cell.address.text = placesData[indexPath.row].address
        cell.averageBill.text = placesData[indexPath.row].averageBill
        cell.categoriesList.text = placesData[indexPath.row].category.joined(separator: ",")
        cell.placeName.text = placesData[indexPath.row].name
        cell.selectedPlace = placesData[indexPath.row]
        cell.selectedPlaceId = placesData[indexPath.row].id
        let inFavorites = cell.configureCellButton(placeId: placesData[indexPath.row].id)
        if inFavorites{
//            Analytics.logEvent(AnalyticsEventSelectItem, parameters: [AnalyticsParameterItemID: placesData[indexPath.row].id])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let placeInfoVC = mainStoryboard.instantiateViewController(identifier: "PlaceInfoVC") as! PlaceInfoViewController
        placeInfoVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        placeInfoVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        placeInfoVC.placesInfo = placesData
        self.present(placeInfoVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        self.title = "Список мест"
        view.layer.cornerRadius = 30
       
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableView()
        
//        SearchManager.shared.searchByCuisineType {[weak self] places in
//            DispatchQueue.main.async {
//                guard let self else {return}
//                self.placesData = places
//                self.tableView.reloadData()
//                MapController().makeCluster(self.placesData)
//            }
//        }
        
              
    }
    
    func setUpTableView(){
         view.addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    }
    

}

