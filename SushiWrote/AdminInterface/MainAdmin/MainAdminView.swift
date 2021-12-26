//
//  MainAdminView.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class MainAdminView: UIView {

    let tableView = UITableView()
    let newGoodsButton = UIButton(title: "Новый товар",
                                  bgColor: ColorsLibrary.darkGreen,
                                  textColor: .white,
                                  font: FontsLibrary.fieldButton)
    let quitButton = UIButton(title: "Выйти",
                              bgColor: ColorsLibrary.redButton,
                              textColor: .white,
                              font: FontsLibrary.fieldButton)
    
    init() {
        super.init(frame: CGRect())
        setConstraints()
        
        backgroundColor = .white
        tableView.register(OrderAdminCell.self,
                           forCellReuseIdentifier: OrderAdminCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func setConstraints() {
        Helper.addSub(views: [tableView, quitButton, newGoodsButton], to: self)
        Helper.tamicOff(views: [tableView, quitButton, newGoodsButton])
        
        NSLayoutConstraint.activate(
            [newGoodsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
             newGoodsButton.topAnchor.constraint(equalTo: topAnchor, constant: 48),
             newGoodsButton.heightAnchor.constraint(equalToConstant: 42),
             newGoodsButton.widthAnchor.constraint(equalToConstant: 130)])
        
        NSLayoutConstraint.activate(
            [quitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
             quitButton.topAnchor.constraint(equalTo: topAnchor, constant: 48),
             quitButton.heightAnchor.constraint(equalToConstant: 42),
             quitButton.widthAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
             tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)])
    }
    
}
