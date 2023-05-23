//
//  ProductsRouter.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import Foundation
import UIKit

protocol ProductsRouter: AnyObject {
    var view: UIViewController! { get set }
}

final class ProductsRouterImpl: ProductsRouter {

    // MARK: - Properties

    var view: UIViewController!

    // MARK: - Lifecycle

    init(model: ProductsModel, networkingService: NetworkingService ) {
        let viewModel = ProductsViewModelImpl(model: model, networkingService: networkingService)
        let view = ProductsViewImpl(viewModel: viewModel)
        self.view = view
        viewModel.router = self
    }

    // MARK: - Internal Methods
    
}
