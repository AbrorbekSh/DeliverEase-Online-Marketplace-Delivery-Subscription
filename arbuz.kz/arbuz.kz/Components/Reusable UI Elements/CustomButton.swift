//
//  CustomButton.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - Lifecycle
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton()
        titleLabell.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupButton(){
        self.backgroundColor = .systemGreen.withAlphaComponent(0.85)
        self.layer.cornerRadius = 16
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews(){
        self.addSubview(titleLabell)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            titleLabell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    //MARK: - UI Elelements
    
    private let titleLabell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .clear
        
        return label
    }()
}
