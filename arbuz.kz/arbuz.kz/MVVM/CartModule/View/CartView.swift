//
//  CartViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit
    
protocol CartView {
    var viewModel: CartViewModel { get set }
}

final class CartViewImpl: UIViewController,  CartView {
    
    //MARK: - Propersties
  
    var viewModel: CartViewModel
    
    private var cartProducts: [Product] = []
    
    //MARK: - LifeCycle
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchProducts()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(productsTableView)
        view.addSubview(continueButton)
        setupProductsTableView()
        setupLayout()
        setupNavigationBar()
        setupViewModel()
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
    
    private func setupViewModel() {
        viewModel.reloadTableView = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.productsTableView.reloadData()
            }
        }
        
        viewModel.updateCartProducts = { [weak self] products in
            guard let strongSelf = self else {
                return
            }
            strongSelf.cartProducts = products
        }
    }
    
    //MARK: - Objective-C methods
    
    @objc private func continueButtonPressed(){
        viewModel.showSubscriptionPage()
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

extension CartViewImpl: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        cell.product = cartProducts[indexPath.row]

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
