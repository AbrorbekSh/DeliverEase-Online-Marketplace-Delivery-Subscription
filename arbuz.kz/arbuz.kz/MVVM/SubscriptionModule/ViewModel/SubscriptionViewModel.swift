//
//  SubscriptionViewModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

protocol SubscriptionViewModel: AnyObject {
    func openAddressPage(with completion: @escaping ((String) -> Void))
    func openFinishPage()
    
    var router: SubscriptionRouter? { get set }
}

final class SubscriptionViewModelImpl: SubscriptionViewModel {
        
    // MARK: - Properties
    
    private var model: SubscriptionModel
    var router: SubscriptionRouter?
    
    private let networkingService: NetworkingService
    
    init(model: SubscriptionModel, networkingService: NetworkingService) {
        self.model = model
        self.networkingService = networkingService
    }
    
    //MARK: - Internal methods
    
    func openAddressPage(with completion: @escaping ((String) -> Void)) {
        router?.openAddressPage(with: completion)
    }
    
    func openFinishPage() {
        router?.openFinishPage()
    }
}




