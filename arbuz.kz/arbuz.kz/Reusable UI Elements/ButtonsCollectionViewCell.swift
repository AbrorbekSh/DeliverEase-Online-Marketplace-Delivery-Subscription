//
//  ButtonsCollectionViewCell.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

final class ButtonsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    
    //MARK: - LifeCycle
    
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
        unselect()
    }
        
    //MARK: - Setup
    
    private func setupView(){
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray.withAlphaComponent(0.1)
        
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    //MARK: - Internal methods
    
    func didSelected(){
        contentView.backgroundColor = .systemGreen.withAlphaComponent(0.85)
        titleLabel.textColor = .white
    }
    
    func unselect(){
        contentView.backgroundColor = .systemGray.withAlphaComponent(0.1)
        titleLabel.textColor = .black
    }
    
    func configureCell(title: String) {
        titleLabel.text = title
    }
    
    func getType() -> String {
        return titleLabel.text ?? ""
    }
    
    //MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        return label
    }()
}
