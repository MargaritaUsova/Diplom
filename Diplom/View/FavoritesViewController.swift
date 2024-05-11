//
//  FavoritesViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 01.02.2024.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var favouritePlaces: [FavouritePlacesDB] = []
    static let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "PlaceInfoCell", bundle: nil), forCellReuseIdentifier: "cellId")
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        favouritePlaces = FavouritePlacesDBManager().fetchFavouritePlaces()
        FavoritesViewController.tableView.reloadData()
    }
    
    
    private func setupUI(){
        view.addSubview(FavoritesViewController.tableView)
        FavoritesViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            FavoritesViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            FavoritesViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            FavoritesViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FavoritesViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        FavoritesViewController.tableView.delegate = self
        FavoritesViewController.tableView.dataSource = self
    }
    

}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PlaceInfoCell
        setupCellInformation(cell, indexPath: indexPath)
        cell.configureCellButton(placeId: favouritePlaces[indexPath.row].placeId)
        let placeInFavourites = cell.checkIfPlaceIsFavourite(with: favouritePlaces[indexPath.row].placeId)
        if !placeInFavourites {
            deleteFromTableView(tableView, forRowAt: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let placeInfoVC = storyboard.instantiateViewController(withIdentifier: "PlaceInfoVC") as! PlaceInfoViewController
        placeInfoVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        placeInfoVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        placeInfoVC.favouritePlacesInfo = favouritePlaces
        placeInfoVC.selectedIndex = indexPath
        self.present(placeInfoVC, animated: true)
    }

    private func setupCellInformation(_ cell: PlaceInfoCell, indexPath: IndexPath){
        cell.selectedPlaceId = favouritePlaces[indexPath.row].placeId
        cell.placeName.text = favouritePlaces[indexPath.row].name
        cell.address.text = favouritePlaces[indexPath.row].address
        cell.averageBill.text = favouritePlaces[indexPath.row].averageBill
        if let categories = favouritePlaces[indexPath.row].categories as? [String]{
            cell.categoriesList.text = categories.joined(separator: ",")
        }
        
    }
    
    private func deleteFromTableView(_ tableView: UITableView, forRowAt indexPath: IndexPath){
        tableView.beginUpdates()
        favouritePlaces.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    
}

