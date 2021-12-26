//
//  OrderProfileCell.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import UIKit

class OrderProfileCell: UITableViewCell {

    static let reuseId = "OrderProfileCell"
    
    let mainLabel = UILabel(text: "Дата", font: FontsLibrary.cellText)
    let detailLabel = UILabel(text: "Статус", font: FontsLibrary.cellText)
    let cardView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
        detailLabel.textAlignment = .right
        cardView.layer.cornerRadius = 12
        cardView.backgroundColor = ColorsLibrary.alphaBlack
        mainLabel.textColor = ColorsLibrary.lightGreen
        detailLabel.textColor = ColorsLibrary.lightGreen
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [mainLabel, detailLabel], axis: .horizontal, spacing: 12)
        
        Helper.addSub(views: [cardView, stack], to: self)
        Helper.tamicOff(views: [cardView, stack])
        
        NSLayoutConstraint.activate([cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                                     cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                                     cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     cardView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                    ])
        
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
