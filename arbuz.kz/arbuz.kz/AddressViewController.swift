//
//  AddressViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 21.05.2023.
//

import UIKit

final class AddressViewController: UIViewController {
    
    //MARK: - Properties
    
    var completion: ((String) -> Void)?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.addSubview(streetTextField)
        view.addSubview(flatTextField)
        view.addSubview(podezdTextField)
        view.addSubview(floorTextField)
        view.addSubview(backgroundImage)
        view.addSubview(continueButton)
        view.addSubview(getLocationButton)
        
        view.backgroundColor = .white

        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            streetTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            streetTextField.heightAnchor.constraint(equalToConstant: 60),
            streetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            streetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            getLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            getLocationButton.heightAnchor.constraint(equalToConstant: 60),
            getLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            getLocationButton.leadingAnchor.constraint(equalTo: streetTextField.trailingAnchor, constant: 10),
            
            flatTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            flatTextField.heightAnchor.constraint(equalToConstant: 60),
            flatTextField.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 52)/3),
            flatTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            podezdTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            podezdTextField.heightAnchor.constraint(equalToConstant: 60),
            podezdTextField.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 52)/3),
            podezdTextField.leadingAnchor.constraint(equalTo: flatTextField.trailingAnchor, constant: 10),
            
            floorTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            floorTextField.heightAnchor.constraint(equalToConstant: 60),
            floorTextField.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 52)/3),
            floorTextField.leadingAnchor.constraint(equalTo: podezdTextField.trailingAnchor, constant: 10),
            
            backgroundImage.topAnchor.constraint(equalTo: floorTextField.bottomAnchor, constant: 150),
            backgroundImage.heightAnchor.constraint(equalToConstant: 200),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    //MARK: - UI Elements
    
    private lazy var streetTextField: CustomTextField = {
        let textField = CustomTextField(delegate: self)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.setPlaceHolder(placeholder: "Улица и номер дома")

        
        return textField
    }()
    
    private lazy var flatTextField: CustomTextField = {
        let textField = CustomTextField(delegate: self)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.setPlaceHolder(placeholder: "Квартира")

        
        return textField
    }()
    
    private lazy var podezdTextField: CustomTextField = {
        let textField = CustomTextField(delegate: self)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.setPlaceHolder(placeholder: "Подъезд")

        
        return textField
    }()
    
    private lazy var floorTextField: CustomTextField = {
        let textField = CustomTextField(delegate: self)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.setPlaceHolder(placeholder: "Этаж")

        
        return textField
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "sad")
        
        return image
    }()
    
    private let getLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "location",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        configuration.baseForegroundColor = .black.withAlphaComponent(0.8)
        configuration.baseBackgroundColor = .white
        button.configuration = configuration
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(getLocationButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let continueButton: CustomButton = {
        let button = CustomButton(title: "Подтвердить адрес")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Objective-C methods
    
    @objc private func continueButtonPressed() {
        var address = ""
        
        if !streetTextField.text.isEmpty {
            address += streetTextField.text
        } else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        if !flatTextField.text.isEmpty {
            address += ", кв. "
            address += flatTextField.text
        }
        
        if !podezdTextField.text.isEmpty {
            address += ", под. "
            address += podezdTextField.text
        }
        
        if !floorTextField.text.isEmpty {
            address += ", эт. "
            address += floorTextField.text
        }
        
        
        completion?(address)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func getLocationButtonPressed() {
        let mapViewController = MapViewController()
        mapViewController.completion = { [weak self] name in
            self?.streetTextField.setText(text: name)
        }
        let naviagtionController = UINavigationController(rootViewController: mapViewController)
        naviagtionController.modalPresentationStyle = .fullScreen
        present(naviagtionController, animated: true, completion: nil)
    }
}


extension AddressViewController: UITextFieldDelegate {
    
}
