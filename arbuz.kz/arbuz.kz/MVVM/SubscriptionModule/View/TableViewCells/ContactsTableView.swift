//
//  ContactsTableView.swift
//  arbuz.kz
//
//  Created by Аброрбек on 20.05.2023.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    
    //MARK: - Properties

    static let identifier = String(describing: ContactsTableViewCell.self)
    var delegate: UITextFieldDelegate!
    
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
    
    //MARK: - internal Methods
    
    func configureCell(placeholder: String){
        textField.setPlaceHolder(placeholder: placeholder)
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.backgroundColor = .white
        contentView.addSubview(textField)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    //MARK: - UI Elements
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField(delegate: delegate)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
}

