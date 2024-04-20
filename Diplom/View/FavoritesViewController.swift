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
        print(favouritePlaces)
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
        cell.selectedPlaceId = favouritePlaces[indexPath.row].placeId
        cell.placeName.text = favouritePlaces[indexPath.row].name
        cell.configureCellButton(placeId: favouritePlaces[indexPath.row].placeId)
        let placeInFavourites = cell.checkIfPlaceIsFavourite(with: favouritePlaces[indexPath.row].placeId)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            favouritePlaces.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}

