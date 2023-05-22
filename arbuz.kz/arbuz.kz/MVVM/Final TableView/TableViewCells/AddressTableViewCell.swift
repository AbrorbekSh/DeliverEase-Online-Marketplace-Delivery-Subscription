//
//  AddressTableViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

final class AddressTableViewCell: UITableViewCell {

    static let identifier = String(describing: AddressTableViewCell.self)
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupLayout()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.backgroundColor = .white
        contentView.addSubview(carImageView)
        contentView.addSubview(addressLabel)
        contentView.addSubview(arrowImageView)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            carImageView.heightAnchor.constraint(equalToConstant: 22),
            carImageView.widthAnchor.constraint(equalToConstant: 25),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 10),
            addressLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 25),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38),

            arrowImageView.heightAnchor.constraint(equalToConstant: 18),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    //MARK: - Internal methods
    
    func setupAddress(address: String){
        addressLabel.text = address
    }
    
    //MARK: - UI Elements
    
    private let carImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(systemName: "car")
        image.tintColor = .black
        
        return image
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Выбрать адрес"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        
        label.backgroundColor = .clear

        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(systemName: "chevron.forward")
        image.tintColor = .systemGray
        
        return image
    }()
}
