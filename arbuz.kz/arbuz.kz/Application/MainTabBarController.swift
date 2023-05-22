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
        let homeViewController = ProductsViewController()
        let homeViewControllerNav = UINavigationController(rootViewController: homeViewController)
        homeViewController.tabBarItem.image = UIImage(systemName: "house")

        let cartViewController = CartViewController()
        let cartViewControllerNav = UINavigationController(rootViewController: cartViewController)
        cartViewController.tabBarItem.image = UIImage(systemName: "cart")
        
        let favouritesViewController = FovouriteItemsViewController()
        let favouritesViewControllerNav = UINavigationController(rootViewController: favouritesViewController)
        favouritesViewController.tabBarItem.image = UIImage(systemName: "heart")
        
        let profileViewController = SubscriptionViewController()
        let profileViewControllerNav = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        
        setViewControllers([homeViewControllerNav, cartViewControllerNav, favouritesViewControllerNav, profileViewControllerNav], animated: true)
    }
    
}

