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
    lazy var searchManager = SearchManager()
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var searchSettingsButton: UIButton = {
        let searchSettingsButton = UIButton(type: .custom)
        let originalImage = UIImage(systemName: "slider.horizontal.3")
        let blackImage = originalImage?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
        let resizedImage = blackImage!.resized(to: CGSize(width: 35, height: 30))
        searchSettingsButton.setImage(resizedImage, for: .normal)
        searchSettingsButton.layer.borderWidth = 1
        searchSettingsButton.layer.borderColor = UIColor.systemGray5.cgColor
        searchSettingsButton.backgroundColor = .white
        searchSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        searchSettingsButton.addTarget(self, action: #selector(searchSettingsButtonAction(_:)), for: .touchUpInside)
        return searchSettingsButton
    }()
    
    let searchBar = UISearchBar()
    static var queryText: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let parsersData = GetParserData()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupUI()
        
    }
    
    @objc private func searchSettingsButtonAction(_ sender: UIButton){
        let searchSettingsVC = SearchFiltersViewController()
        navigationController?.pushViewController(searchSettingsVC, animated: true)
    }
    
    private func setupUI(){
        view.backgroundColor = .systemGray6
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(searchSettingsButton)
        
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.trailingAnchor.constraint(equalTo: searchSettingsButton.leadingAnchor),

            searchSettingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchSettingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchSettingsButton.heightAnchor.constraint(equalToConstant: 60),
            searchSettingsButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    

}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ButtonsSetupInfo.buttonsImagesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            fatalError("Failed to deque MenuCollectionViewCell in SearchViewController")
        }
        
        let buttonImageName = ButtonsSetupInfo.buttonsImagesNames[indexPath.row]
        let buttonName = ButtonsSetupInfo.buttonsNames[indexPath.row]
        
        cell.configureMenuCell(with: buttonImageName, name: buttonName)
        cell.menuButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
          return cell
      }

     
      @objc func buttonAction(_ sender: UIButton) {
          if let buttonText = sender.titleLabel?.text {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController {
                  SearchViewController.queryText = buttonText
                  
            
                  
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
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}


extension SearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController {
//            SearchViewController.queryText = searchBar.text!
//            SearchManager.shared.searchByQuery{[weak self] places in
//                DispatchQueue.main.async {
//                    guard let self else {return}
//                    SearchResultsViewController.placesData = places
//                    if let presentedViewController = self.presentedViewController, presentedViewController is SearchResultsViewController {
//                        return
//                    } else {
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController {
//                            self.present(searchResultsViewController, animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

