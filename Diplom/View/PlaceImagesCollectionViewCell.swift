//
//  PlaceImagesCollectionViewCell.swift
//  Diplom
//
//  Created by Margarita Usova on 01.05.2024.
//

import UIKit

class PlaceImagesCollectionViewCell: UICollectionViewCell {
    static let indentifier = "PlaceImagesCollectionViewCell"
    var placeImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        return indicatorView
        }()
    
    
    public func configureImageCell(image: UIImage){
        self.placeImage.image = image
        if image != nil {
            activityIndicatorView.stopAnimating()
        }
        self.setupUI()
    }
    
    private func setupUI(){
        
        self.layer.cornerRadius = 10
        self.addSubview(activityIndicatorView)
        self.addSubview(placeImage)
        
        
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeImage.topAnchor.constraint(equalTo: self.topAnchor),
            placeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            placeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: placeImage.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: placeImage.centerYAnchor)
        ])
        
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeImage.image = nil
    }
}
