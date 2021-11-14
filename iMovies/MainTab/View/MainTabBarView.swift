//
//  MainView.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit

class MainTabBarView: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    private func setControllers() {
        
        let navigationHome = UINavigationController(rootViewController: HomeRouter().viewController)
        navigationHome.tabBarItem.image = UIImage(systemName: "house")
        navigationHome.tabBarItem.selectedImage = UIImage(systemName: "house.filled")
        navigationHome.title = "Home"
        
        let navigationCategories = UINavigationController(rootViewController: CategoriesRouter().viewController)
        navigationCategories.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        navigationCategories.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.filled")
        navigationCategories.title = "Genres"
        
        let navigationSearch = UINavigationController(rootViewController: SearchRouter().viewController)
        navigationSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationSearch.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.filled")
        navigationSearch.title = "Search"
        
        viewControllers = [navigationHome, navigationCategories, navigationSearch]
    }
    
}
