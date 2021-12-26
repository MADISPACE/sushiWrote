//
//  OrderAdminCell.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class OrderAdminCell: UITableViewCell {
    
    static let reuseId: String = "OrderAdminCell"
    
    let dateLabel = UILabel(text: "26.12.2021",
                            font: FontsLibrary.cellText)
    
    let statusLabel = UILabel(text: "Новый", font: FontsLibrary.cellText)
    
    let priceLabel = UILabel(text: "2300 р.", font: FontsLibrary.cellText)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(views: [dateLabel,
                                        statusLabel,
                                        priceLabel],
                                axis: .horizontal,
                                spacing: 12)
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stack.leadingAnchor.constraint(equalTo: leadingAnchor),
             stack.trailingAnchor.constraint(equalTo: trailingAnchor),
             stack.topAnchor.constraint(equalTo: topAnchor),
             stack.bottomAnchor.constraint(equalTo: bottomAnchor) ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
