//
//  SubscriptionModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

struct SubscriptionModel {
    var address: AddressModel
    var day: String
    var time: String
    var period: String
    var name: String
    var phoneNumber: String
    var comment: String?
    
    mutating func validateAddress(_ address: String){
        self.address = AddressModel(address: address)
    }
    
    mutating func validateDay(_ day: String){
        self.day = day
    }
    
    mutating func validateTime(_ time: String){
        self.time = time
    }
    
    mutating func validatePeriod(_ period: String){
        self.period = period
    }
    
    mutating func validateName(_ name: String){
        self.name = name
    }
    
    mutating func validatePhoneNumber(_ number: String){
        self.phoneNumber = number
    }
    
    mutating func validateComment(_ comment: String){
        self.comment = comment
    }
    
    func chechValidity() -> Bool {
        if address.address.count == 0 {
            return false
        }
        if day.count == 0 {
            return false
        }
        if time.count == 0 {
            return false
        }

        if period.count == 0 {
            return false
        }

        if name.count == 0 {
            return false
        }
        if phoneNumber.count == 0 {
            return false
        }
        return true
    }
}
