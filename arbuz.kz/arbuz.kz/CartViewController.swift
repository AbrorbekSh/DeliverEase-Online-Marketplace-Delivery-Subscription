//
//  CartViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    //MARK: - Propersties
    
    private var productsCart: [Product] = []
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productsCart = products.filter({ $0.requiredAmount != 0 })
        productsTableView.reloadData()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(productsTableView)
        view.addSubview(continueButton)
        setupProductsTableView()
        setupLayout()
        setupNavigationBar()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "Корзина"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setupProductsTableView(){
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    //MARK: - Objective-C methods
    
    @objc private func continueButtonPressed(){
        let subscriptionlViewController = SubscriptionViewController()
        self.navigationController?.pushViewController(subscriptionlViewController, animated: true)
    }
    
    //MARK: - UI Elements
    
    private let productsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.backgroundColor = .white
        table.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        
        return table
    }()
    
    private let continueButton: CustomButton = {
        let button = CustomButton(title: "Продолжить")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        return button
    }()
}

//MARK: - UITableViewDataSource and UITableViewDelegate extension

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        cell.configureCell(product: productsCart[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.bottom
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
