//
//  CartRouter.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import Foundation
import UIKit

protocol CartRouter: AnyObject {
    var view: UIViewController { get set }
    
    func showSubscriptionPage()
}

final class CartRouterImpl: CartRouter {

    // MARK: - Properties

    var view: UIViewController

    // MARK: - Lifecycle

    init(model: CartModel, networkingService: NetworkingService ) {
        let viewModel = CartViewModelImpl(model: model, networkingService: networkingService)
        let view = CartViewImpl(viewModel: viewModel)
        self.view = view
        viewModel.router = self
    }

    // MARK: - Internal Methods
    
    func showSubscriptionPage() {
        let subscriptionlView = Assembly.shared.makeSubscriptionModuleView()
        view.navigationController?.pushViewController(subscriptionlView, animated: true)
    }
}
