//
//  FovouriteItemsViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import UIKit

final class FovouriteItemsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "Избранное"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}
