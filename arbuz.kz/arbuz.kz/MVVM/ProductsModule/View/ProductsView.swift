//
//  ProductsViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
//

import UIKit

protocol ProductsView {
    var viewModel: ProductsViewModel { get set }
}

final class ProductsViewImpl: UIViewController, ProductsView {
    
    //MARK: - Properties
    
    var viewModel: ProductsViewModel
    
    private let context = ["Все", "Фрукты", "Овощи", "Молочные"]
    private var previousIndexPath = IndexPath(row: 0, section: 0)
    private var products = [Product]()
    
    //MARK: - LifeCycle
    
    init(viewModel: ProductsViewModel) {
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
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setupCollectionViews()
        setupLayout()
        setupNavigationBar()
        setpViewModel()
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
}

//MARK: - CollectionView Extension

extension ProductsViewImpl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == self.collectionView else {
            return products.count
        }
        return context.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == self.productsCollectionView else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.title = context[indexPath.row]
            if indexPath == previousIndexPath {
                cell.didSelected()
            }
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.product = products[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == self.collectionView else {
            return
        }
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
        
        selectedCell.didSelected()
        
        guard let unselectedCell = collectionView.cellForItem(at: previousIndexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
        
        unselectedCell.unselect()
        previousIndexPath = indexPath
        
        viewModel.filterProducts(type: selectedCell.getType())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard collectionView == self.collectionView else {
            return CGSize(width: view.frame.size.width/2-24, height: view.frame.size.width/2 + 50)
        }
        return CGSize(
            width: context[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 25,
            height: 30
        )
    }
}
