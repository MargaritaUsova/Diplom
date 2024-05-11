//
//  SearchSettingsViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 03.05.2024.
//

import UIKit

class SearchFiltersViewController: UIViewController {
    
    private var selectedFilter: String = ""
    
    static var placesTypesEnumFilters: [String: [String]] = [:]
    private var selectedPlacesTypes: Set<String> = []
    private var selectedPrices: Set<String> = []
    private var selectedCuisineTypes: Set<String> = []
    private var selectedPlacesFeatures: Set<String> = []
    
    private var isPlacesTypesStackViewExpanded = false
    private var isCuisineButtonsStackViewExpanded = false

    var placesResult: [Place] = []
    private var cuisineLabel: UILabel!
    private var priceLabel: UILabel!
    private var placesTypesLabel: UILabel!
    private var placesFeaturesLabel: UILabel!
    
    private var cuisineButtonsStackView: UIStackView!
    private var pricesButtonsStackView: UIStackView!
    private var placesTypesStackView: UIStackView!
    private var placesFeaturesStackView: UIStackView!
    
    private var needShowAllButtonCuisineTypes: Bool = false
    private var needShowAllButtonPlacesTypes: Bool = false
    private var needShowAllButtonPlacesFeatures: Bool = false
    
    private var showAllPlacesTypesButton: UIButton!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
       }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle("Найти", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.cornerRadius = 15
        searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    private let backButton: UIBarButtonItem = {
       let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.style = .plain
        backButton.action = #selector(backButtonTapped)
        
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
    }
    
    private func setupShowAllButton(stackView: UIStackView) -> UIButton{
        let button = UIButton()
        button.setTitle("Показать все", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        return button
    }
    
    private func setupLabel(with text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        return label
    }
    
    private func setupStackView() -> UIStackView{
        let stackView = UIStackView()
         stackView.axis = .vertical
         stackView.alignment = .fill
         stackView.distribution = .fillEqually
         stackView.spacing = 15
         return stackView
    }
    
    @objc private func showAllCuisinesTypesButtonTapped(_ sender: UIButton){
        if sender.titleLabel?.text == "Показать все"{
            needShowAllButtonCuisineTypes.toggle()
            sender.setTitle("Скрыть", for: .normal)
        }
        else{
            needShowAllButtonCuisineTypes.toggle()
            sender.setTitle("Показать все", for: .normal)
        }
        setupButtons(needShowAllButton: needShowAllButtonCuisineTypes, array: AcceptableFilters.cuisineTypes, stackView: cuisineButtonsStackView, label: cuisineLabel)
    }
    
    @objc private func showAllPlacesFeaturesButtonTapped(_ sender: UIButton){
        if sender.titleLabel?.text == "Показать все"{
            needShowAllButtonPlacesFeatures.toggle()
            sender.setTitle("Скрыть", for: .normal)
        }
        else{
            needShowAllButtonPlacesFeatures.toggle()
            sender.setTitle("Показать все", for: .normal)
        }
        setupButtons(needShowAllButton: needShowAllButtonPlacesFeatures, array: AcceptableFilters.placesFeatures, stackView: placesFeaturesStackView, label: placesFeaturesLabel)
    }
    
    @objc private func showAllPlacesTypesButtonTarget(_ sender: UIButton){
        if sender.titleLabel?.text == "Показать все" {
            needShowAllButtonPlacesTypes.toggle()
            sender.setTitle("Скрыть", for: .normal)
        }
        else{
            needShowAllButtonPlacesTypes.toggle()
            sender.setTitle("Показать все", for: .normal)
        }
        setupButtons(needShowAllButton: needShowAllButtonPlacesTypes, array: AcceptableFilters.placesTypes, stackView: placesTypesStackView, label: placesTypesLabel)
        updateSearchButtonConstraints()
    }
    
    private func updateSearchButtonConstraints() {
        if needShowAllButtonPlacesTypes {
            NSLayoutConstraint.activate([
                searchButton.topAnchor.constraint(equalTo: showAllPlacesTypesButton.bottomAnchor, constant: 10)
            ])
        } else {
            NSLayoutConstraint.activate([
                searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                searchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            ])
        }
    }
    
    @objc private func searchButtonTapped(_ sender: UIButton){
        if !selectedCuisineTypes.isEmpty{
            SearchFiltersViewController.placesTypesEnumFilters["кухня"] = Array(selectedCuisineTypes)
        }
        if !selectedPrices.isEmpty{
            SearchFiltersViewController.placesTypesEnumFilters["цены"] = Array(selectedPrices)
        }
        if !selectedPlacesTypes.isEmpty{
            SearchFiltersViewController.placesTypesEnumFilters["тип заведения"] = Array(selectedPlacesTypes)
        }
        if !selectedPlacesFeatures.isEmpty{
            SearchFiltersViewController.placesTypesEnumFilters["особенности заведения"] = Array(selectedPlacesFeatures)
        }
        print("Search types enum filters", SearchFiltersViewController.placesTypesEnumFilters)
       
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController {
//            SearchManager.shared.searchBySettedFilters {[weak self] places in
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
//            
//        }
       
    }
    
    @objc func cuisineButtonTapped(_ sender: UIButton){
        let grayColor = UIColor(red: 179.0 / 255.0, green: 200.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
        let greenColor = UIColor(red: 135.0 / 255.0, green: 169.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0)
        if sender.backgroundColor == grayColor{
            sender.backgroundColor = greenColor
            if let title = sender.titleLabel?.text {
                if AcceptableFilters.cuisineTypes.contains(title){
                    selectedFilter = "кухня"
                    selectedCuisineTypes.insert(sender.titleLabel!.text!)
                } else  if AcceptableFilters.prices.contains(title){
                    selectedFilter = "цены"
                    selectedPrices.insert(sender.titleLabel!.text!)
                }
                else if AcceptableFilters.placesTypes.contains(title){
                    selectedFilter = "тип заведения"
                    selectedPlacesTypes.insert(sender.titleLabel!.text!)
                }
                else if AcceptableFilters.placesFeatures.contains(title){
                    selectedFilter = "особенности заведения"
                    selectedPlacesFeatures.insert(sender.titleLabel!.text!)
                }
            }
            else {
                selectedFilter = ""
            }
        }
        else {
            sender.backgroundColor = grayColor
            if let title = sender.titleLabel?.text {
                if AcceptableFilters.cuisineTypes.contains(title){
                    selectedFilter = "кухня"
                    selectedCuisineTypes.remove(sender.titleLabel!.text!)
                } else  if AcceptableFilters.prices.contains(title){
                    selectedFilter = "цены"
                    selectedPrices.remove(sender.titleLabel!.text!)
                }
                else if AcceptableFilters.placesTypes.contains(title){
                    selectedFilter = "тип заведения"
                    selectedPlacesTypes.remove(sender.titleLabel!.text!)
                }
                else if AcceptableFilters.placesFeatures.contains(title){
                    selectedFilter = "особенности заведения"
                    selectedPlacesFeatures.remove(sender.titleLabel!.text!)
                }
                
            }
            else {
                selectedFilter = ""
            }
        }
    }

    @objc func backButtonTapped(){
        SearchFiltersViewController.placesTypesEnumFilters = [:]
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI(){
        backButton.target = self
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Фильтры"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        cuisineLabel = setupLabel(with: "Кухня")
        priceLabel = setupLabel(with: "Цены")
        placesTypesLabel = setupLabel(with: "Тип заведения")
        placesFeaturesLabel = setupLabel(with: "Особенности заведения")
        
        cuisineButtonsStackView = setupStackView()
        pricesButtonsStackView = setupStackView()
        placesTypesStackView = setupStackView()
        placesFeaturesStackView = setupStackView()
        
        NSLayoutConstraint.activate([
            cuisineLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        let cuisineTypesArray = needShowAllButtonCuisineTypes ? AcceptableFilters.cuisineTypes : checkShouldShowAllButton(AcceptableFilters.cuisineTypes)
        setupFilterStackView(cuisineTypesArray, stackView: cuisineButtonsStackView, label: cuisineLabel)
        let showAllCuisineTypesButton = setupShowAllButton(stackView: cuisineButtonsStackView)
        showAllCuisineTypesButton.addTarget(self, action: #selector(showAllCuisinesTypesButtonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: showAllCuisineTypesButton.bottomAnchor, constant: 0)
        ])
        setupFilterStackView(AcceptableFilters.prices, stackView: pricesButtonsStackView, label: priceLabel)
        
        let placesFeaturesArray = needShowAllButtonPlacesFeatures ? AcceptableFilters.placesFeatures : checkShouldShowAllButton(AcceptableFilters.placesFeatures)
        setupFilterStackView(placesFeaturesArray, stackView: placesFeaturesStackView, label: placesFeaturesLabel)
        let showAllPlacesFeaturesButton = setupShowAllButton(stackView: placesFeaturesStackView)
        showAllPlacesFeaturesButton.addTarget(self, action: #selector(showAllPlacesFeaturesButtonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            placesFeaturesLabel.topAnchor.constraint(equalTo: pricesButtonsStackView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            placesTypesLabel.topAnchor.constraint(equalTo: placesFeaturesStackView.bottomAnchor, constant: 45)
        ])
        
        let placesTypesArray = needShowAllButtonPlacesTypes ? AcceptableFilters.placesTypes : checkShouldShowAllButton(AcceptableFilters.placesTypes)
        setupFilterStackView(placesTypesArray, stackView: placesTypesStackView, label: placesTypesLabel)
        showAllPlacesTypesButton = setupShowAllButton(stackView: placesTypesStackView)
        showAllPlacesTypesButton.addTarget(self, action: #selector(showAllPlacesTypesButtonTarget(_:)), for: .touchUpInside)
        
        contentView.addSubview(searchButton)
            NSLayoutConstraint.activate([            
                placesTypesStackView.bottomAnchor.constraint(equalTo: showAllPlacesTypesButton.topAnchor, constant: -15),
                searchButton.topAnchor.constraint(equalTo: showAllPlacesTypesButton.bottomAnchor, constant: 10),
                searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                searchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
                contentView.bottomAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 15)
            ])
    }
    
    private func setupButtons(needShowAllButton: Bool, array: [String], stackView: UIStackView, label: UILabel){
        if needShowAllButton{
            let partOfArray = Array(array.suffix(from: 7))
            setupFilterStackView(partOfArray, stackView: stackView, label: label)
        }
        else {
            let fullArray = Array(array.prefix(7))
            for arrangedSubview in stackView.arrangedSubviews{
                stackView.removeArrangedSubview(arrangedSubview)
                arrangedSubview.removeFromSuperview()
            }
            setupFilterStackView(fullArray, stackView: stackView, label: label)
        }
    }
    
    private func checkShouldShowAllButton(_ array: [String]) -> [String]{
        var shortArray: [String] = []
        if array.count > 7{
           shortArray = Array(array.prefix(7))
        }
        return shortArray
    }
    
    private func setupFilterStackView(_ array: [String], stackView: UIStackView, label: UILabel){
        let maxWidth = UIScreen.main.bounds.width - 30
        var currentRowButtons: [UIButton] = []
        var currentRowWidth: CGFloat = 0
        
        for item in array {
            let button = setupFilterButton(with: item)
            let buttonWidth = button.intrinsicContentSize.width + 10
            let width = (currentRowWidth + buttonWidth)
            let occupiedSpace = CGFloat((currentRowButtons.count - 1) * 15)
        
            if width + occupiedSpace <= maxWidth {
                currentRowButtons.append(button)
                currentRowWidth += buttonWidth
            } else {
                let rowStackView = UIStackView(arrangedSubviews: currentRowButtons)
                rowStackView.axis = .horizontal
                rowStackView.alignment = .fill
                rowStackView.distribution = .fill
                rowStackView.spacing = 10
                stackView.addArrangedSubview(rowStackView)
                currentRowButtons.removeAll()
                currentRowButtons.append(button)
                currentRowWidth = buttonWidth
            }
        }
        
        if !currentRowButtons.isEmpty {
            let rowStackView = UIStackView(arrangedSubviews: currentRowButtons)
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fill
            rowStackView.spacing = 5
            stackView.addArrangedSubview(rowStackView)
        }

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])
    }
    
    private func setupFilterButton(with name: String) -> UIButton{
        let filterVariantButton = UIButton()
        filterVariantButton.setTitle(name, for: .normal)
        filterVariantButton.addTarget(self, action: #selector(cuisineButtonTapped(_:)), for: .touchUpInside)
        filterVariantButton.sizeToFit()
        let red: CGFloat = 179.0 / 255.0
        let green: CGFloat = 200.0 / 255.0
        let blue: CGFloat = 207.0 / 255.0
        filterVariantButton.setTitleColor(.black, for: .normal)

        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        filterVariantButton.backgroundColor = color
        filterVariantButton.layer.cornerRadius = 10
        filterVariantButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let titleSize = (name as NSString).size(withAttributes: [NSAttributedString.Key.font: filterVariantButton.titleLabel?.font as Any])
        let buttonWidth = titleSize.width + 10
        filterVariantButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return filterVariantButton
    }

   
}

