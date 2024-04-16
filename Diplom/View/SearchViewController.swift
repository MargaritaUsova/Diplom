//
//  ViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 31.01.2024.
//

import UIKit

class SearchViewController: UIViewController {

    private var buttonsImages: [UIImage] = []
    private var menuButtons: [UIButton] = []
    
    private let buttonsImagesNames = ["Asia", "Bakery", "Breakfast", "Cake", "Chinese", "Coffee", "CurryRice", "Fastfood", "Kavkaz", "Pasta", "Pizza", "Poke", "Shawarma", "Shrimp", "Steak", "Sushi", "Taco", "Vegan"]
    
    private let buttonsNames = ["Азиатское", "Выпечка", "Завтрак", "Десерты", "Китайское", "Кофе", "Индийское", "Фастфуд", "Кавказское", "Паста", "Пицца", "Поке", "Шаурма", "Морепродукты", "Мясо", "Суши", "Мексиканское", "Веганское"]
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    let searchBar = UISearchBar()
    static var buttonText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupUI()

    }
    
    private func setupUI(){
        view.backgroundColor = .systemGray6
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant:  60)
        ])
        
    }

}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonsImagesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            fatalError("Failed to deque MenuCollectionViewCell in SearchViewController")
        }
        
        let buttonImageName = buttonsImagesNames[indexPath.row]
        let buttonName = buttonsNames[indexPath.row]
        
        cell.configure(with: buttonImageName, name: buttonName)
        cell.menuButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
          return cell
      }

     
      @objc func buttonAction(_ sender: UIButton) {
          if let buttonText = sender.titleLabel?.text {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController {
                  SearchViewController.buttonText = buttonText
                  self.present(searchResultsViewController, animated: true, completion: nil)
              }
          }
      }
    
}


extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 15 * 4
        let availableWidth = collectionView.bounds.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
}
