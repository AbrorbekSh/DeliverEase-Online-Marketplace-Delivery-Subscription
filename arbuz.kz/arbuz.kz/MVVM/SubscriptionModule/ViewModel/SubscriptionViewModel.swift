//
//  SubscriptionViewModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

protocol SubscriptionViewModel: AnyObject {
    func openAddressPage(with completion: @escaping ((String) -> Void))
    func openFinishPage() -> Bool
    
    func validateAddress(address: String)
    func validateDay(day: String)
    func validateTime(time: String)
    func validatePeriod(period: String)
    func validateName(name: String)
    func validatePhoneNumber(number: String)
    func validateComments(comment: String)
    
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
    
    func openFinishPage() -> Bool {
        if model.chechValidity() {
            router?.openFinishPage()
            return true
        }
        return false
    }
    
    func validateAddress(address: String) {
        model.validateAddress(address)
    }
    
    func validateDay(day: String) {
        model.validateDay(day)
    }
    
    func validateTime(time: String) {
        model.validateTime(time)
    }
    
    func validatePeriod(period: String) {
        model.validatePeriod(period)
    }
    
    func validateName(name: String) {
        model.validateName(name)
    }
    
    func validatePhoneNumber(number: String) {
        model.validatePhoneNumber(number)
    }
    func validateComments(comment: String){
        model.validateComment(comment)
    }
}




