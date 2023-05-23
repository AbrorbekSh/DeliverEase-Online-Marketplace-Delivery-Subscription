//
//  SubscriptionRouter.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import Foundation
import UIKit

protocol SubscriptionRouter: AnyObject {
    func openAddressPage(with completion: @escaping ((String) -> Void))
    func openFinishPage()
    
    var view: UIViewController { get set }
}

final class SubscriptionRouterImpl: SubscriptionRouter {

    // MARK: - Properties

    var view: UIViewController

    // MARK: - Lifecycle

    init(model: SubscriptionModel, networkingService: NetworkingService ) {
        let viewModel = SubscriptionViewModelImpl(model: model, networkingService: networkingService)
        let view = SubscriptionViewImpl(viewModel: viewModel)
        self.view = view
        viewModel.router = self
    }

    // MARK: - Internal Methods
    
    func openAddressPage(with completion: @escaping ((String) -> Void)) {
        guard let addressViewController = Assembly.shared.makeAddressModuleView() as? AddressViewImpl else {
            return
        }

        addressViewController.completion = completion
        view.navigationController?.pushViewController(addressViewController, animated: true)
    }
    
    func openFinishPage(){
        let finishlViewController = Assembly.shared.makeFinishViewController()
        
        let naviagtionController = UINavigationController(rootViewController: finishlViewController)
        naviagtionController.modalPresentationStyle = .fullScreen
        let completion: (() -> Void)? = {
            self.view.tabBarController?.selectedIndex = 0
        }
        view.present(naviagtionController, animated: true, completion: completion)
    }
}
