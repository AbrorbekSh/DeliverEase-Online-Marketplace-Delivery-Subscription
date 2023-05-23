//
//  FavouriteViewModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

protocol FavouriteItemsViewModel: AnyObject {
    func fetchProducts()
    
    var reloadCollectionView: (() -> Void)? { get set }
    var updateProducts: (([Product]) -> Void)? { get set }
    
    var router: FavouriteItemsRouter? { get set }
}

final class FavouriteItemsViewModelImpl: FavouriteItemsViewModel {
        
    // MARK: - Properties
    
    private var model: FavouriteItemsModel
    var router: FavouriteItemsRouter?
    
    private let networkingService: NetworkingService
    
    var reloadCollectionView: (() -> Void)?
    var updateProducts: (([Product]) -> Void)?
    
    init(model: FavouriteItemsModel, networkingService: NetworkingService) {
        self.model = model
        self.networkingService = networkingService
    }
    
    //MARK: - Internal methods
    
    func fetchProducts(){
        let currentProducts: [Product] = []
        model.updateProducts(products: currentProducts)
        self.updateProducts?(model.products)
        self.reloadCollectionView?()
    }
}



