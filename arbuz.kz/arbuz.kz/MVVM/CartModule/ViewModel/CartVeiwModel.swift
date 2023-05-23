//
//  CartVeiwModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

protocol CartViewModel: AnyObject {
    func fetchProducts()
    func showSubscriptionPage()

    var reloadTableView: (() -> Void)? { get set }
    var updateCartProducts: (([Product]) -> Void)? { get set }
    
    var router: CartRouter? { get set }
}

final class CartViewModelImpl: CartViewModel {
        
    // MARK: - Properties
    
    private var model: CartModel
    var router: CartRouter?
    
    private let networkingService: NetworkingService
    
    var reloadTableView: (() -> Void)?
    var updateCartProducts: (([Product]) -> Void)?
    
    init(model: CartModel, networkingService: NetworkingService) {
        self.model = model
        self.networkingService = networkingService
    }
    
    //MARK: - Internal methods
    
    func fetchProducts(){
        let currentProducts = networkingService.fetchProducts()
        model.updateProducts(products: currentProducts)
        self.updateCartProducts?(model.products)
        self.reloadTableView?()
    }
    
    func showSubscriptionPage() {
        router?.showSubscriptionPage()
    }
}



