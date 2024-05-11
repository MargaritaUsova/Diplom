//
//  PlaceInfoViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 07.04.2024.
//

import UIKit

class PlaceInfoViewController: UIViewController {
    var placesInfo: [Place] = []
    var favouritePlacesInfo: [FavouritePlacesDB] = []
    var selectedIndex: IndexPath = [0,0]
    private var currentPlace: Place!
    private var image: UIImage!
    private var imageData: Data!
    
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
    
    private func prepareSelectedPlace(){
        if placesInfo.isEmpty{
            if let favouritePlaceData = favouritePlacesInfo[selectedIndex.row] as? FavouritePlacesDB{
                let favouritePlaceData = favouritePlacesInfo[selectedIndex.row]
                currentPlace = Place(point: nil, geoObject: nil,
                                     name: favouritePlaceData.name!,
                                     category: favouritePlaceData.categories as! [String],
                                     address: favouritePlaceData.address,
                                     id: favouritePlaceData.placeId!,
                                     phoneNumbers: favouritePlaceData.phoneNumbers as? [String],
                                     
                                     photos: favouritePlaceData.photos as? [String])
            }
        }
        else{
            currentPlace = placesInfo[selectedIndex.row]
        }
        
    }
    
 
    func setupUI(){
        placeName.text = currentPlace.name
        if let phoneNumber = currentPlace.phoneNumbers?.joined(separator: ", "){
            if phoneNumber != " "{
                placePhones.text = "Телефон: \(phoneNumber)"
            }
        }
       
        
        view.addSubview(placeName)
        view.addSubview(collectionView)
        view.addSubview(placePhones)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            placeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 20),
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            placePhones.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            placePhones.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placePhones.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
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
