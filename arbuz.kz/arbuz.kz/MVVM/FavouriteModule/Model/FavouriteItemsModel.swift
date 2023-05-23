//
//  FavouriteItemsModel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit

struct FavouriteItemsModel {
    private(set) var products: [Product] = []
    
    mutating func updateProducts(products: [Product]) {
        self.products = products
    }
}
