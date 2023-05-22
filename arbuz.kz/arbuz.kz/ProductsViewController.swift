//
//  ProductsViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    //MARK: - Properties
    
    private let context = ["Все", "Фрукты", "Овощи", "Молочные"]
    private var previousIndexPath = IndexPath(row: 0, section: 0)
    private var filteredProducts = products
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productsCollectionView.reloadData()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.addSubview(productsCollectionView)
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setupCollectionViews()
        setupLayout()
        setupNavigationBar()
    }
    
    private func setupCollectionViews(){
        collectionView.dataSource = self
        productsCollectionView.dataSource = self
        
        collectionView.delegate = self
        productsCollectionView.delegate = self
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            productsCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Arbuz.kz"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
    }
    
    //MARK: - UI Elements
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        collection.backgroundColor = .white
        
        return collection
    }()
    
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
    
    //MARK: - Private methods
    
    private func filterProducts(type: String) {
        var filteredType: String
        
        switch type {
            case "Все":
                filteredType = "All"
            case "Фрукты":
                filteredType = "Fruits"
            case "Овощи":
                filteredType = "Vegetables"
            case "Молочные":
                filteredType = "Milk"
            default:
                filteredType = type
        }
        
        if filteredType == "All" {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.type == filteredType }
        }
        
        productsCollectionView.reloadData()
    }
}

//MARK: - CollectionView Extension

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productsCollectionView {
            return filteredProducts.count
        } else {
            return context.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell( product: filteredProducts[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(title: context[indexPath.row])
            if indexPath == previousIndexPath {
                cell.didSelected()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            
            selectedCell.didSelected()
            
            guard let unselectedCell = collectionView.cellForItem(at: previousIndexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            
            unselectedCell.unselect()
            previousIndexPath = indexPath
            
            filterProducts(type: selectedCell.getType())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView {
            return CGSize(
                width: context[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 25,
                height: 30)
        }
        
        return CGSize(width: view.frame.size.width/2-24, height: view.frame.size.width/2 + 50)
    }

}
