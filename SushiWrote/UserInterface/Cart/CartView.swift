//
//  CartView.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class CartView: UIView {

    let titleLabel = UILabel(text: "Корзина",
                             font: FontsLibrary.largeTitle)
    let tableView = UITableView()
    let finalLabel = UILabel(text: "ИТОГО к оплате: ",
                             font: FontsLibrary.smallTitle)
    let sumLabel = UILabel(text: "20000 р.",
                           font: FontsLibrary.smallTitle)
    let clearButton = UIButton(title: "Очистить корзину",
                               bgColor: ColorsLibrary.redButton,
                               textColor: .white,
                               font: FontsLibrary.fieldButton)
    let orderButton = UIButton(title: "Заказать",
                               bgColor: ColorsLibrary.darkGreen,
                               textColor: .white,
                               font: FontsLibrary.fieldButton)
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setViews()
        setConstraints()
    }
    
    func setViews() {
        
        tableView.register(PositionCell.self, forCellReuseIdentifier: PositionCell.reuseId)
    }
    
    func setConstraints() {
        
        let resultStack = UIStackView(views: [finalLabel, sumLabel], axis: .horizontal, spacing: 20)
        let buttonsStack = UIStackView(views: [clearButton, orderButton], axis: .horizontal, spacing: 12)
        
        let stack = UIStackView(views: [titleLabel, tableView, resultStack, buttonsStack], axis: .vertical, spacing: 12)
        
        addSubview(stack)
        Helper.tamicOff(views: [stack])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: topAnchor, constant: 54),
                                     stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor)
                                    ])
        
        NSLayoutConstraint.activate([clearButton.widthAnchor.constraint(equalTo: orderButton.widthAnchor),
                                     clearButton.heightAnchor.constraint(equalTo: orderButton.heightAnchor),
                                     orderButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
