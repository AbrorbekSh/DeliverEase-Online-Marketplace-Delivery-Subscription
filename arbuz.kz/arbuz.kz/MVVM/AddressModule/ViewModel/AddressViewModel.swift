//
//  AddressViewModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

protocol AddressViewModel: AnyObject {
    func openMap(with completion: @escaping ((String) -> Void))
    func dismissAddressView()
    
    var router: AddressRouter? { get set }
}

final class AddressViewModelImpl: AddressViewModel {
        
    // MARK: - Properties
    
    private var model: AddressModel
    var router: AddressRouter?
    
    private let networkingService: NetworkingService
    
    init(model: AddressModel, networkingService: NetworkingService) {
        self.model = model
        self.networkingService = networkingService
    }
    
    //MARK: - Internal methods
    
    func openMap(with completion: @escaping ((String) -> Void)){
        router?.openMap(with: completion)
    }
    
    func dismissAddressView(){
        router?.dismissAddressView()
    }
}
