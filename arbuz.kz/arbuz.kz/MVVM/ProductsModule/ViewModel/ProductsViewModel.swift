//
//  ProductsViewModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import UIKit

protocol ProductsViewModel: AnyObject {
    func fetchProducts()
    func filterProducts(type: String)
    
    var reloadCollectionView: (() -> Void)? { get set }
    var updateProducts: (([Product]) -> Void)? { get set }
    
    var router: ProductsRouter? { get set }
}

final class ProductsViewModelImpl: ProductsViewModel {
        
    // MARK: - Properties
    
    private var model: ProductsModel
    var router: ProductsRouter?
    
    private let networkingService: NetworkingService
    
    var reloadCollectionView: (() -> Void)?
    var updateProducts: (([Product]) -> Void)?
    
    init(model: ProductsModel, networkingService: NetworkingService) {
        self.model = model
        self.networkingService = networkingService
    }
    
    //MARK: - Internal methods
    
    func fetchProducts(){
        let currentProducts = networkingService.fetchProducts()
        model.updateProducts(products: currentProducts)
        self.updateProducts?(model.products)
        self.reloadCollectionView?()
    }
    
    func filterProducts(type: String){
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
        
        model.filterProducts(type: filteredType)
        updateProducts?(model.filteredProducts)
        self.reloadCollectionView?()
    }
}


