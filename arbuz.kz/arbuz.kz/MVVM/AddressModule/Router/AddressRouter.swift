//
//  AddressRouter.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import Foundation
import UIKit

protocol AddressRouter: AnyObject {
    func openMap(with completion: @escaping ((String) -> Void))
    func dismissAddressView()
    
    var view: UIViewController { get set }
}

final class AddressRouterImpl: AddressRouter {

    // MARK: - Properties

    var view: UIViewController

    // MARK: - Lifecycle

    init(model: AddressModel, networkingService: NetworkingService ) {
        let viewModel = AddressViewModelImpl(model: model, networkingService: networkingService)
        let view = AddressViewImpl(viewModel: viewModel)
        self.view = view
        viewModel.router = self
    }

    // MARK: - Internal Methods
    
    func openMap(with completion: @escaping ((String) -> Void)) {
        let mapViewController = MapViewController()
        mapViewController.completion = completion
        let naviagtionController = UINavigationController(rootViewController: mapViewController)
        naviagtionController.modalPresentationStyle = .fullScreen
        view.present(naviagtionController, animated: true, completion: nil)
    }
    
    func dismissAddressView(){
        view.navigationController?.popViewController(animated: true)
    }
}
