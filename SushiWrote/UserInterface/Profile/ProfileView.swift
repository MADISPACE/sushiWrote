//
//  ProfileView.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class ProfileView: UIView {

    let avatar = UIImageView()
    let nameTextField = UITextField(placeholder: "")
    let addressTitleLabel = UILabel(text: "Адрес доставки:",
                                    font: FontsLibrary.smallButton)
    let addressLabel = UILabel(text: "Улица Пушкина Дом Колотушкина",
                               font: FontsLibrary.smallButton)
    let changeAddressButton = UIButton(title: "Изменить адрес",
                                       bgColor: ColorsLibrary.darkGreen,
                                       textColor: .white,
                                       font: FontsLibrary.fieldButton)
    let phoneLabel = UILabel(text: "+79999999999",
                             font: FontsLibrary.smallButton)
    let changePhone = UIButton(title: "Изменить",
                               bgColor: ColorsLibrary.redButton,
                               textColor: .white,
                               font: FontsLibrary.fieldButton)
    let tableView = UITableView()
    let quitButton = UIButton(title: "Выйти",
                              bgColor: ColorsLibrary.redButton,
                              textColor: .white,
                              font: FontsLibrary.fieldButton)
    
    init() {
        super.init(frame: CGRect())
        setViews()
        setConstraints()
    }
    
    func setViews() {
        backgroundColor = .white
        avatar.backgroundColor = .systemGreen
        avatar.layer.cornerRadius = 55
        avatar.clipsToBounds = true
        nameTextField.text = "Вася Пупкин"
        nameTextField.borderStyle = .none
        nameTextField.layer.shadowOpacity = 0
        tableView.register(OrderProfileCell.self, forCellReuseIdentifier: OrderProfileCell.reuseId)
        avatar.isUserInteractionEnabled = true
    }
    
    func setConstraints() {
        let topStack = UIStackView(views: [avatar, nameTextField],
                                   axis: .horizontal,
                                   spacing: 36)
        let phoneStack = UIStackView(views: [phoneLabel, changePhone],
                                     axis: .horizontal,
                                     spacing: 36)
        
        let stack = UIStackView(views: [topStack,
                                        addressTitleLabel,
                                        addressLabel,
                                        changeAddressButton,
                                        phoneStack,
                                        tableView,
                                        quitButton],
                                axis: .vertical,
                                spacing: 12)
        
        for view in stack.arrangedSubviews where view is UILabel {
            (view as! UILabel).textColor = ColorsLibrary.darkGreen
        }
        
        Helper.tamicOff(views: [stack,
                                topStack,
                                addressTitleLabel,
                                addressLabel,
                                phoneStack,
                                tableView,
                                quitButton,
                                avatar,
                                nameTextField,
                                phoneLabel,
                                changePhone])
        addSubview(stack)
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: topAnchor, constant: 64),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
                                    ])
        
        NSLayoutConstraint.activate([avatar.heightAnchor.constraint(equalToConstant: 110),
                                     avatar.widthAnchor.constraint(equalToConstant: 110),
                                    ])
        
        NSLayoutConstraint.activate([changeAddressButton.heightAnchor.constraint(equalToConstant: 40),
                                     changePhone.heightAnchor.constraint(equalToConstant: 40),
                                     quitButton.heightAnchor.constraint(equalToConstant: 40),
                                     changePhone.widthAnchor.constraint(equalToConstant: 160)
                                    ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
