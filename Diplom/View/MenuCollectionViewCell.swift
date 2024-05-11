//
//  MenuCollectionViewCell.swift
//  Diplom
//
//  Created by Margarita Usova on 15.04.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
     let menuButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        return button
    }()
    
    
    public func configureMenuCell(with imageName: String, name: String){
        self.menuButton.setImage(UIImage(named: imageName), for: .normal)
        self.menuButton.setTitle(name, for: .normal)
        self.menuButton.setTitleColor(.black, for: .normal)
        self.menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
      
        self.menuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        self.menuButton.titleEdgeInsets = UIEdgeInsets(top: 70, left: -50, bottom: 0, right: 15)
         
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 10
        self.addSubview(menuButton)
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: self.topAnchor),
            menuButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            menuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        menuButton.setTitle(nil, for: .normal)
        menuButton.setImage(nil, for: .normal)
    }
}
