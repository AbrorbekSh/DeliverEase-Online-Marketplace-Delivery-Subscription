//
//  FovouriteItemsViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import UIKit

protocol FavouriteItemsView {
    var viewModel: FavouriteItemsViewModel { get set }
}

final class FavouriteItemsViewImpl: UIViewController, FavouriteItemsView {
    
    //MARK: - Properties
    
    var viewModel: FavouriteItemsViewModel
    
    private var products = [Product]()
    
    //MARK: - LifeCycle
    
    init(viewModel: FavouriteItemsViewModel) {
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
        view.addSubview(productsCollectionView)
        view.backgroundColor = .white
        setupCollectionView()
        setupLayout()
        setupNavigationBar()
        setpViewModel()
    }
    
    private func setupCollectionView(){
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Избранное"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setpViewModel(){
        viewModel.reloadCollectionView = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.productsCollectionView.reloadData()
            }
        }
        
        viewModel.updateProducts = { [weak self] products in
            guard let strongSelf = self else {
                return
            }
            strongSelf.products = products
        }
    }
    
    //MARK: - UI Elements
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collection.backgroundColor = .white
        
        return collection
    }()
}

//MARK: - CollectionView Extension

extension FavouriteItemsViewImpl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.isFavouirteState = true
        cell.product = products[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width/2-24, height: view.frame.size.width/2 + 50)
    }
}

