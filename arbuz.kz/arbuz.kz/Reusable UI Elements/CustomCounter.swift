//
//  CounterButton.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
//

import UIKit

final class CustomCounter: UIView {
    
    //MARK: - Properties
    
    private var counter: Float = 0

    var product: Product? {
        didSet {
            priceLabel.text = String(product?.price ?? 1200) + " тг"
            counter = product?.requiredAmount ?? 0
            incrementCounter()
            decrementCounter()
        }
    }
    
    //MARK: - LifeCycle
    
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .systemGray.withAlphaComponent(0.1)
        self.layer.cornerRadius = 16
        setupSubviews()
        setupLayout()
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupUIElements(){
        if counter == 0 {
            minusButton.isHidden = true
            counterLabel.isHidden = true
            priceLabel.isHidden = false
        } else {
            priceLabel.isHidden = true
            minusButton.isHidden = false
            counterLabel.isHidden = false
        }
    }
    
    private func setupSubviews(){
        self.addSubview(priceLabel)
        self.addSubview(plusButton)
        self.addSubview(minusButton)
        self.addSubview(counterLabel)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            minusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            minusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            minusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            plusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            counterLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    //MARK: - UI Elements
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGreen
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
        
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(decrementCounter), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Objective-C methods
    
    @objc private func incrementCounter(){
        if counter == product?.availableAmount {
            disableButton()
            return
        }
        
        if let measure = product?.measure {
            if measure == "sht" {
                counter += 1
                counterLabel.text = String(Int(counter))
            } else if measure == "kg" {
                counter += 0.5
                counterLabel.text = String(counter) + " kg"
            }
        }
        
        product?.requiredAmount = counter
        setupUIElements()
    }
    
    private func disableButton(){
        plusButton.tintColor = .systemGray
        plusButton.isEnabled = false
    }
    
    private func enableButton(){
        plusButton.tintColor = .systemGreen
        plusButton.isEnabled = true
    }
    
    @objc private func decrementCounter(){
        if let measure = product?.measure {
            if measure == "sht" {
                if counter > 1 {
                    counter -= 1
                    counterLabel.text = String(Int(counter))
                } else if counter == 1 {
                    counter = 0
                    setupUIElements()
                }
            } else if measure == "kg" {
                if counter > 0.5 {
                    counter -= 0.5
                    counterLabel.text = String(counter) + " kg"
                } else if counter == 0.5 {
                    counter = 0
                    setupUIElements()
                }
            }
        }
        
        enableButton()
        product?.requiredAmount = counter
    }
}
