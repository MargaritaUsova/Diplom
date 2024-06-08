//
//  TabBarViewController.swift
//  Diplom
//
//  Created by Margarita Usova on 04.05.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.backgroundColor = .systemGroupedBackground
        tabBar.layer.borderWidth = 0.2
        tabBar.layer.borderColor = UIColor.gray.cgColor
    }
    

    private func setupTabs(){
        let search = createNavC(with: "Поиск", image: UIImage(systemName: "magnifyingglass")!, vc: SearchViewController())
        let favorites = createNavC(with: "Избранное", image: UIImage(systemName: "star")!, vc: FavoritesViewController())
        let account = createNavC(with: "Рекомендации", image: UIImage(systemName: "person")!, vc: RecommendationsViewController())
        
        self.setViewControllers([search, favorites, account], animated: true)
    }
    
    private func createNavC(with title: String, image: UIImage, vc: UIViewController) -> UINavigationController{
        let navC = UINavigationController(rootViewController: vc)
        navC.tabBarItem.image = image
        navC.tabBarItem.title = title
        navC.navigationController?.setNavigationBarHidden(true, animated: false)
        return navC
    }
}
