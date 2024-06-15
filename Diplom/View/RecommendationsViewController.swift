//
//  AccountViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 01.02.2024.
//

import UIKit

class RecommendationsViewController: UIViewController {

    var recommendations: [FavouritePlacesDB] = []
    static let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "PlaceInfoCell", bundle: nil), forCellReuseIdentifier: "cellId")
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Рекомендации"
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        view.addSubview(RecommendationsViewController.tableView)
        RecommendationsViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            RecommendationsViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            RecommendationsViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            RecommendationsViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            RecommendationsViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        RecommendationsViewController.tableView.delegate = self
        RecommendationsViewController.tableView.dataSource = self
    }




}
extension RecommendationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RecommendationEngine.recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PlaceInfoCell
        setupCellInformation(cell, indexPath: indexPath)
        cell.configureCellButton(placeId:  RecommendationEngine.recommendations[indexPath.row].placeId)
        let placeInFavourites = cell.checkIfPlaceIsFavourite(with: RecommendationEngine.recommendations[indexPath.row].placeId)
        
        return cell
    }

    private func setupCellInformation(_ cell: PlaceInfoCell, indexPath: IndexPath){
        cell.selectedPlaceId = RecommendationEngine.recommendations[indexPath.row].placeId
        cell.placeName.text = RecommendationEngine.recommendations[indexPath.row].name
        cell.address.text = RecommendationEngine.recommendations[indexPath.row].address
        cell.averageBill.text = RecommendationEngine.recommendations[indexPath.row].averageBill
        if let categories = RecommendationEngine.recommendations[indexPath.row].categories as? [String]{
            cell.categoriesList.text = categories.joined(separator: ", ")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    
}

