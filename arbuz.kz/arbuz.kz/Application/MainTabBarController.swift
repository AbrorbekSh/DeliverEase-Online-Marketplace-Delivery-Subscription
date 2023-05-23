//
//  MainTabBarController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 20.05.2023.
//


import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .systemGreen
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
        
        setViews()
    }
    
    private func setViews() {
        let homeView = Assembly.shared.makeProductsModuleView()
        let homeViewNav = UINavigationController(rootViewController: homeView)
        homeView.tabBarItem.image = UIImage(systemName: "house")

        let cartView = Assembly.shared.makeCartModuleView()
        let cartViewNav = UINavigationController(rootViewController: cartView)
        cartView.tabBarItem.image = UIImage(systemName: "cart")
        
        let favouritesView = Assembly.shared.makeFavouriteItemsModuleView()
        let favouritesViewNav = UINavigationController(rootViewController: favouritesView)
        favouritesView.tabBarItem.image = UIImage(systemName: "heart")
        
        let profileView = Assembly.shared.makeSubscriptionModuleView()
        let profileViewNav = UINavigationController(rootViewController: profileView)
        profileView.tabBarItem.image = UIImage(systemName: "person")
        
        setViewControllers([homeViewNav, cartViewNav, favouritesViewNav, profileViewNav], animated: true)
    }
    
}

