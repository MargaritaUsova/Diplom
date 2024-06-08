//
//  PlaceInfoViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 07.04.2024.
//

import UIKit
import YandexMapsMobile

class PlaceInfoViewController: UIViewController {
    private var placeLinks = UILabel()
    private var isOpen = UILabel()
    private var workingHoursLabel = UILabel()
    private var workingHoursHeader = UILabel()
    private var contactsLabelHeader = UILabel()
    private var kitchenLabelHeader = UILabel()
    private var kitchenLabel = UILabel()
    private var paymentFeaturesLabelHeader = UILabel()
    private var paymentFeaturesLabel = UILabel()
    private var placeFeaturesLabelHeader = UILabel()
    private var placeFeaturesLabel = UILabel()
    private var averageBillLabelHeader = UILabel()
    private var averageBillLabel = UILabel()
    private var addressLabelHeader = UILabel()
    private var addressLabel = UILabel()
    
     var placesInfo: [Place] = []
     var favouritePlacesInfo: [FavouritePlacesDB] = []
     var selectedIndex: IndexPath = [0,0]
    private var currentPlace: Place!
    private var image: UIImage!
    private var imageData: Data!
    
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
    
    
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(PlaceImagesCollectionViewCell.self, forCellWithReuseIdentifier: PlaceImagesCollectionViewCell.indentifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()
    
    private let placeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let placePhones: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byClipping
        label.numberOfLines = 3
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSelectedPlace()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
    }
    
    private func makeLabel() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    private func prepareSelectedPlace(){
        if placesInfo.isEmpty{
            if let favouritePlaceData = favouritePlacesInfo[selectedIndex.row] as? FavouritePlacesDB{
                let favouritePlaceData = favouritePlacesInfo[selectedIndex.row]
                SearchManager().searchByUri(uri: favouritePlacesInfo[selectedIndex.row].uri!)
                currentPlace = SearchResultsViewController.placesData.first
            }
        }
        else{
            currentPlace = placesInfo[selectedIndex.row]
        }
    }

    private func makeConstraints(topLabel: UILabel, bottomLabel: UILabel){
        contentView.addSubview(bottomLabel)
        NSLayoutConstraint.activate([
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
        bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)])
    }
    
    
    func setupUI(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
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
        
        placeLinks = makeLabel()
        isOpen = makeLabel()
        workingHoursLabel = makeLabel()
        workingHoursHeader = makeLabel()
        contactsLabelHeader = makeLabel()
        kitchenLabel = makeLabel()
        kitchenLabelHeader = makeLabel()
        paymentFeaturesLabel = makeLabel()
        paymentFeaturesLabelHeader = makeLabel()
        placeFeaturesLabel = makeLabel()
        placeFeaturesLabelHeader = makeLabel()
        averageBillLabelHeader = makeLabel()
        averageBillLabel = makeLabel()
        addressLabelHeader = makeLabel()
        addressLabel = makeLabel()
        
        let metadata = currentPlace.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
        let time = metadata.workingHours!.text
        
        var placeIsOpen = metadata.workingHours?.state?.isOpenNow as? NSNumber
        if let placeIsOpen = placeIsOpen{
            isOpen.text = (placeIsOpen == 1) ? "Открыто сейчас" : "Закрыто сейчас"
            isOpen.font = UIFont.boldSystemFont(ofSize: 20)
            isOpen.textColor = (placeIsOpen == 1) ? .systemGreen : .red
        }
        
        workingHoursHeader.font = UIFont.boldSystemFont(ofSize: 20)
        workingHoursHeader.text = "Часы работы"
        workingHoursLabel.text = time
        contactsLabelHeader.text = "Контакты"
        contactsLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        kitchenLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        kitchenLabelHeader.text = "Кухня"
        if let kitchen = currentPlace.features?["кухня"] as? [String]{
            kitchenLabel.text = kitchen.joined(separator: ", ")
        }
        paymentFeaturesLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        paymentFeaturesLabelHeader.text = "Способ оплаты"
        if let payment = currentPlace.features?["способ оплаты"] as? [String]{
            paymentFeaturesLabel.text = payment.joined(separator: ", ")
        }
        
        placeFeaturesLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        placeFeaturesLabelHeader.text = "Особенности заведения"
        if let featurePlace = currentPlace.features?["особенности заведения"] as? [String]{
            var features = featurePlace
            if let specialMenu = currentPlace.features?["специальное меню"] as? [String]{
                if specialMenu.contains("детское"){
                    features.insert("детское меню", at: 0)
                }
            }
            if let wheelChair = currentPlace.features?["доступность помещения на инвалидной коляске"] as? [String]{
                if wheelChair == ["доступно"]{
                    features.insert("доступно посещение на инвалидной коляске", at: 0)
                }
            }
            
            placeFeaturesLabel.text = features.joined(separator: ", ")
        }
        if let features = currentPlace.features as? [String: Any]{
            for (key, val) in features{
                print(key, " : ", val)
            }
        }
        
        averageBillLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        averageBillLabelHeader.text = "Средний счёт"
        if let averageBill = currentPlace.features?["средний счёт"] as? [String]{
            averageBillLabel.text = averageBill.joined()
        }
        
        
        placeName.text = currentPlace.name
        if let phoneNumber = currentPlace.phoneNumbers?.joined(separator: "\n"){
            if phoneNumber != " "{
                let text = "Позвонить: "
                let attributedString = NSMutableAttributedString(string: text)
                        let phoneNumberAttributedString = NSAttributedString(
                            string: phoneNumber,
                            attributes: [
                               
                                .link: "tel://\(phoneNumber)",
                                .foregroundColor: UIColor.blue
                            ]
                        )
                        attributedString.append(phoneNumberAttributedString)
                placePhones.attributedText = attributedString
            }
            if let links = currentPlace.links{
                let text = "Ссылки: "
                var email = links.joined(separator: "\n")
                let normalFont = UIFont.systemFont(ofSize: 17)
                       let smallFont = UIFont.systemFont(ofSize: 14)
                       let attributedString = NSMutableAttributedString(string: text, attributes: [.font: normalFont])
                       let emailAttributedString = NSAttributedString(
                           string: email,
                           attributes: [
                               .font: smallFont,
                               .link: "mailto:\(email)",
                               .foregroundColor: UIColor.blue
                           ]
                       )
                       attributedString.append(emailAttributedString)
                       placeLinks.attributedText = attributedString
                }
        }
        
        addressLabelHeader.font = UIFont.boldSystemFont(ofSize: 20)
        addressLabelHeader.text = "Адрес"
        if let address = currentPlace.address{
            addressLabel.text = address
        }
        
        
        contentView.addSubview(isOpen)
        contentView.addSubview(placeName)
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            isOpen.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            isOpen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            isOpen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        makeConstraints(topLabel: isOpen, bottomLabel: workingHoursHeader)
        makeConstraints(topLabel: workingHoursHeader, bottomLabel: workingHoursLabel)
        makeConstraints(topLabel: workingHoursLabel, bottomLabel: contactsLabelHeader)
        makeConstraints(topLabel: contactsLabelHeader, bottomLabel: placePhones)
        makeConstraints(topLabel: placePhones, bottomLabel: placeLinks)
        makeConstraints(topLabel: placeLinks, bottomLabel: kitchenLabelHeader)
        makeConstraints(topLabel: kitchenLabelHeader, bottomLabel: kitchenLabel)
        makeConstraints(topLabel: kitchenLabel, bottomLabel: averageBillLabelHeader)
        makeConstraints(topLabel: averageBillLabelHeader, bottomLabel: averageBillLabel)
        makeConstraints(topLabel: averageBillLabel, bottomLabel: paymentFeaturesLabelHeader)
        makeConstraints(topLabel: paymentFeaturesLabelHeader, bottomLabel: paymentFeaturesLabel)
        makeConstraints(topLabel: paymentFeaturesLabel, bottomLabel: placeFeaturesLabelHeader)
        makeConstraints(topLabel: placeFeaturesLabelHeader, bottomLabel: placeFeaturesLabel)
        makeConstraints(topLabel: placeFeaturesLabel, bottomLabel: addressLabelHeader)
        makeConstraints(topLabel: addressLabelHeader, bottomLabel: addressLabel)
        
        
        
        if let lastSubview = contentView.subviews.last {
            lastSubview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }
    
}


extension PlaceInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = currentPlace.photos{
            return photos.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceImagesCollectionViewCell.indentifier, for: indexPath) as? PlaceImagesCollectionViewCell else{
            fatalError("Failed to deque PlaceImagesCollectionViewCell in PlaceInfoViewCOntroller")
        }
            if let photos = self.currentPlace.photos,
               let photo = photos[indexPath.row],
               let imageURL = URL(string: photo)
            {
                let task = URLSession.shared.dataTask(with: imageURL){data, response, error in
                    if let error = error{
                        fatalError("\(error)")
                    }
                    guard let data = data else{
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageData = data
                        self.image = UIImage(data: self.imageData)
                        cell.configureImageCell(image: self.image)
                          }
                    }
                task.resume()
                }
                
        cell.contentMode = .scaleAspectFit
        return cell
    }

}


extension PlaceInfoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 40, right: 0)
    }
        
}
