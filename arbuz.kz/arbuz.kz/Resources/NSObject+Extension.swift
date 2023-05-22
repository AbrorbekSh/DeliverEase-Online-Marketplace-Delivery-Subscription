//
//  NSObject+Extension.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: self)
    }
}
