//
//  ProductsModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import UIKit

struct ProductsModel {
    private(set) var products: [Product] = []
    private(set) var filteredProducts: [Product] = []
    
    mutating func updateProducts(products: [Product]) {
        self.products = products
    }
    
    mutating func filterProducts(type: String) {
        if type == "All" {
            filteredProducts = products
        } else {
            self.filteredProducts = products.filter({
                $0.type == type
            })
        }
    }
}


