//
//  Product.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import Foundation
import UIKit

final class Product: Hashable {
    let image: UIImage
    let name: String
    let price: Int
    let type: String
    let measure: String
    let availableAmount: Float
    var requiredAmount: Float = 0
    
    init(image: UIImage, name: String, price: Int, type: String, measure: String, availableAmount: Float){
        self.image = image
        self.name = name
        self.price = price
        self.type = type
        self.measure = measure
        self.availableAmount = availableAmount
    }
    
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == lhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
