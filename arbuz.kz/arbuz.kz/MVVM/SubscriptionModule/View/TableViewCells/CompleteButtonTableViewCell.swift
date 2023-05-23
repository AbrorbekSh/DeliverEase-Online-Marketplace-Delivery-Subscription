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
        contentView.addSubview(buttonLabel)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            buttonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    //MARK: - UI Elements
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Оформить подписку"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 16

        label.backgroundColor = .systemGreen.withAlphaComponent(0.85)
        label.layer.masksToBounds = true

        return label
    }()
}


