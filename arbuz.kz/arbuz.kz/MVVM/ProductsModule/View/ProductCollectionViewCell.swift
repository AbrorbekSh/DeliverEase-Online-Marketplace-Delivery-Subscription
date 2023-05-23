//
//  CustomCollectionViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
// 165

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    
    //MARK: - Properties
    
    var product: Product? {
        didSet {
            imageView.image = product?.image
            productName.text = product?.name
            counterButton.product = product
        }
    }
    
    //MARK: -LifeCycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        productName.text = nil
        counterButton.product = nil
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(productName)
        contentStackView.addArrangedSubview(counterButton)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.width),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            
            counterButton.heightAnchor.constraint(equalToConstant: 35),
            counterButton.widthAnchor.constraint(equalToConstant: 110),
            
            productName.heightAnchor.constraint(equalToConstant: 20)
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
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
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
    
    private lazy var counterButton: CustomCounter = {
        let button = CustomCounter()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
}
