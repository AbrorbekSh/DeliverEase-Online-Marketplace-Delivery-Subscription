//
//  PopupLabel.swift
//  arbuz.kz
//
//  Created by Аброрбек on 24.05.2023.
//

import Foundation
import UIKit


final class PopupLabel: UILabel {
    init() {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupLabel(){
        self.backgroundColor = .systemRed.withAlphaComponent(0.4)
        self.textAlignment = .center
        self.text = "Остались незаполненные поля!"
        self.tintColor = .black
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
}
