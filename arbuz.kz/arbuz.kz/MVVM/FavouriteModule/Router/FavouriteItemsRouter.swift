//
//  FavouriteRouter.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import Foundation
import UIKit

protocol FavouriteItemsRouter: AnyObject {
    var view: UIViewController { get set }
}

final class FavouriteItemsRouterImpl: FavouriteItemsRouter {

    // MARK: - Properties

    var view: UIViewController

    // MARK: - Lifecycle

    init(model: FavouriteItemsModel, networkingService: NetworkingService ) {
        let viewModel = FavouriteItemsViewModelImpl(model: model, networkingService: networkingService)
        let view = FavouriteItemsViewImpl(viewModel: viewModel)
        self.view = view
        viewModel.router = self
    }

    // MARK: - Internal Methods
    
}
