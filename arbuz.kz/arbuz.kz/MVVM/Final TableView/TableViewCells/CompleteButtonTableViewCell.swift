//
//  CompleteButtonTableViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 21.05.2023.
//

import UIKit

final class CompleteButtonTableViewCell: UITableViewCell {
    
    //MARK: - Properties

    static let identifier = String(describing: CompleteButtonTableViewCell.self)
    var view: SubscriptionViewController?

    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.backgroundColor = .white
        contentView.addSubview(continueButton)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    //MARK: - UI Elements
    
    private lazy var continueButton: CustomButton = {
        let button = CustomButton(title: "Оформить подписку")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Objective-C methods
    
    @objc private func continueButtonPressed(){
        let finishlViewController = FinishViewController()
        finishlViewController.parentView = view
        let naviagtionController = UINavigationController(rootViewController: finishlViewController)
        naviagtionController.modalPresentationStyle = .fullScreen
        view?.present(naviagtionController, animated: true, completion: nil)
    }
}


