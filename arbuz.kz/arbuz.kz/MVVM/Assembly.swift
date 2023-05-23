//
//  Assembly.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import Foundation
import UIKit

final class Assembly {
    
    static let shared = Assembly()
    private let networkingService = NetworkingService()
    
    func makeProductsModuleView() -> UIViewController {
        let model = ProductsModel()
        
        let router = ProductsRouterImpl(
            model: model,
            networkingService: networkingService
        )
        
        return router.view
    }
    
    func makeCartModuleView() -> UIViewController {
        let model = CartModel()
        
        let router = CartRouterImpl(
            model: model,
            networkingService: networkingService
        )
        
        return router.view
    }
    
    func makeSubscriptionModuleView() -> UIViewController {
        let model = SubscriptionModel()
        
        let router = SubscriptionRouterImpl(
            model: model,
            networkingService: networkingService
        )
        
        return router.view
    }
    
    func makeAddressModuleView() -> UIViewController {
        let model = AddressModel()
        
        let router = AddressRouterImpl(
            model: model,
            networkingService: networkingService
        )
        
        return router.view
    }
    
    func makeFinishViewController() -> UIViewController {
        let finishView = FinishViewController()
        
        return finishView
    }
    
    func makeMapViewController() -> UIViewController {
        let mapView = MapViewController()
        
        return mapView
    }
}
