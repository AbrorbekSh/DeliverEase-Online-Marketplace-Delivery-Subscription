//
//  CustomTableViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CartTableViewCell.self)
    
    //MARK: - Properties
    
    var product: Product? {
        didSet {
            productImageView.image = product?.image
            productName.text = product?.name
            amountMeasure.text = product?.measure
            counterButton.product = product
        }
    }
    
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
        contentView.addSubview(productImageView)
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(productName)
        contentStackView.addArrangedSubview(amountMeasure)
        contentStackView.addArrangedSubview(counterButton)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - 20),
            productImageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.height - 20),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            counterButton.heightAnchor.constraint(equalToConstant: 35),
            counterButton.widthAnchor.constraint(equalToConstant: 110),
        ])
    }
    
    //MARK: - UI Elements
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.spacing = 10
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .leading
        
        return view
    }()
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.backgroundColor = .systemGray.withAlphaComponent(0.3)
        
        return image
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        label.numberOfLines = 1
        
        return label
    }()
    
    private let amountMeasure: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var counterButton: CustomCounter = {
        let button = CustomCounter()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
}
