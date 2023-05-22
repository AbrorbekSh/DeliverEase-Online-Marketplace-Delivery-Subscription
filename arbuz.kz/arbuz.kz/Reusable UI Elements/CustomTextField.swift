//
//  CustomTextField.swift
//  arbuz.kz
//
//  Created by Аброрбек on 20.05.2023.
//

import UIKit

final class CustomTextField: UIView {
    
    // MARK: - Properties
    
    @IBInspectable var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }

    var text: String {
        return textField.text ?? ""
    }
    
    //MARK: - Lifecycle
    
    init(delegate: UITextFieldDelegate){
        super.init(frame: .zero)
        textField.delegate = delegate
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let radius = 15.0
        
        enum TextField {
            static let horizontalMargin: CGFloat = 16.0
            static let verticalMargin: CGFloat = 14.0
            
            static let fontSize = 20.0
            static let font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
            
            static let placeHolder = "Теру"
        }
    }
    
    // MARK: - Setup
    
    private func setupTextField() {
        self.layer.cornerRadius = Constants.radius
        self.backgroundColor = .white
        
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews(){
        self.addSubview(textField)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.TextField.verticalMargin),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.TextField.verticalMargin),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.TextField.horizontalMargin),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.TextField.horizontalMargin)
        ])
    }
    
    //MARK: - Internal Methods
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event){
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    func setPlaceHolder(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray.withAlphaComponent(0.5)]
        )
    }
    
    func setText(text: String) {
        textField.text = text
    }
    
    //MARK: - UIElements
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.textColor = .black
        textField.font = Constants.TextField.font
        textField.keyboardType = .default
        textField.textAlignment = .left
        
        return textField
    }()
}


