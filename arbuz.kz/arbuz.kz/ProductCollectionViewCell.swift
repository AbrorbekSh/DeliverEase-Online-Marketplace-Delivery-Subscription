//
//  CustomCollectionViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 18.05.2023.
// 165

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    private var product: Product?
    
    //MARK: -LifeCycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.width),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            
            counterButton.heightAnchor.constraint(equalToConstant: 35),
            counterButton.widthAnchor.constraint(equalToConstant: 110),
            
            productName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(productName)
        contentStackView.addArrangedSubview(counterButton)
    }
    
    //MARK: - Internal Methods
    
    func configureCell(product: Product){
        imageView.image = product.image
        productName.text = product.name
        
        counterButton.configureCounter(product: product)
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
    
    lazy var counterButton: CustomCounter = {
        let button = CustomCounter()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
}
