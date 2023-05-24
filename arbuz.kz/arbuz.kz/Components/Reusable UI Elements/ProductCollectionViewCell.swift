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
    
    var isFavouirteState: Bool = false {
        didSet{
            setFavouriteState(isFavouirteState)
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
        contentView.addSubview(favouriteButton)
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
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 18),
            favouriteButton.widthAnchor.constraint(equalToConstant: 18),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.width),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            
            counterButton.heightAnchor.constraint(equalToConstant: 35),
            counterButton.widthAnchor.constraint(equalToConstant: 110),
            
            productName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: - Pricate methods
    
    private func setFavouriteState(_ isFavourite: Bool){
        switch isFavourite {
        case true:
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: "suit.heart.fill",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
            configuration.baseForegroundColor = .systemRed
            configuration.baseBackgroundColor = .clear
            favouriteButton.configuration = configuration
        case false:
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: "heart",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
            configuration.baseForegroundColor = .systemGray
            configuration.baseBackgroundColor = .clear
            favouriteButton.configuration = configuration
        }
    }
    
    //MARK: - Objective-C methods
    
    @objc private func favouriteButtonPressed(){
        isFavouirteState = !isFavouirteState
        setFavouriteState(isFavouirteState)
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
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "heart",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
        configuration.baseForegroundColor = .systemGray
        configuration.baseBackgroundColor = .clear
        button.configuration = configuration
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        
        return button
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
