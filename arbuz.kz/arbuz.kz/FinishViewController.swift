//
//  FinishViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import UIKit

final class FinishViewController: UIViewController {
    
    //MARK: - Propertires
    
    var parentView: SubscriptionViewController?
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(congratulationsLabel)
        setupLayout()
        setupNaviagtionController()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 250),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            congratulationsLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -30),
            congratulationsLabel.heightAnchor.constraint(equalToConstant: 60),
            congratulationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            congratulationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupNaviagtionController(){
        let image = UIImage(systemName: "xmark")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(dismissButton))
    }
    
    //MARK: - Objective-C methods
    
    @objc private func dismissButton(){
        dismiss(animated: true)
        parentView?.tabBarController?.selectedIndex = 0
    }
    
    //MARK: - UI Elements
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Ваш заказ принят!"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.masksToBounds = true 
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "finish")
        
        return image
    }()

}
