//
//  FinalViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 19.05.2023.
//

import UIKit

protocol SubscriptionView {
    var viewModel: SubscriptionViewModel { get set }
}

final class SubscriptionViewImpl: UIViewController, SubscriptionView {
    
    //MARK: - Properties
    
    var viewModel: SubscriptionViewModel
    
    private let times = ["07:00-09:00", "08:00-10:00", "09:00-11:00", "10:00-12:00", "11:00-13:00", "12:00-14:00", "13:00-15:00", "14:00-16:00", "15:00-17:00", "16:00-18:00", "17:00-19:00", "18:00-20:00", "19:00-21:00", "20:00-22:00", "21:00-23:00", "22:00-00:00"]

    private let dates = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

    private let periods = ["2 недели", "1 месяц", "2 месяца", "3 месяца", "6 месяцев", "1 год"]
    
    //MARK: - LifeCycle
    
    init(viewModel: SubscriptionViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(contentTableView)
        setupLayout()
        setupTableView()
        setupNavigationController()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView(){
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    private func setupNavigationController(){
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    //MARK: - UI Elements
    
    private let contentTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        table.separatorStyle = .none

        table.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.identifier)
        table.register(OptionsTableViewCell.self, forCellReuseIdentifier: OptionsTableViewCell.identifier)
        table.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        table.register(CompleteButtonTableViewCell.self, forCellReuseIdentifier: CompleteButtonTableViewCell.identifier)
        
        return table
    }()
}

//MARK: - UITableViewDelegate and UITableViewDelegate Extension

extension SubscriptionViewImpl: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 4:
            return 3
        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as? AddressTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell

        case 1...3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsTableViewCell.identifier, for: indexPath) as? OptionsTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none

            switch indexPath.section {
            case 1:
                cell.configureCell(context: dates)
            case 2:
                cell.configureCell(context: times)
            case 3:
                cell.configureCell(context: periods)
            default:
                break
            }
            return cell

        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as? ContactsTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.selectionStyle = .none

            switch indexPath.row {
            case 0:
                cell.configureCell(placeholder: "Имя получателя")
            case 1:
                cell.configureCell(placeholder: "Номер телефона")
            case 2:
                cell.configureCell(placeholder: "Комментарий")
            default:
                break
            }
            return cell

        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompleteButtonTableViewCell.identifier, for: indexPath) as? CompleteButtonTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: headerView.bounds)
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        headerView.addSubview(label)

        switch section {
        case 0:
            label.text = "Адрес"
        case 1:
            label.text = "Дата доставки"
        case 2:
            label.text = "Время доставки"
        case 3:
            label.text = "Период подписки"
        case 4:
            label.text = "Контактная информация"
        default:
            break
        }

        return headerView
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let cell = contentTableView.cellForRow(at: indexPath) as? AddressTableViewCell else { return }

            let completion = { address in
                    cell.setupAddress(address: address)
            }
            
            viewModel.openAddressPage(with: completion)
        case 5:
            viewModel.openFinishPage()
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0...3:
            return 70
        case 4:
            return 90
        default:
            return 55
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.bottom
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: min(0, -offset))
    }
}

extension SubscriptionViewImpl: UITextFieldDelegate {

}
