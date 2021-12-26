//
//  PositionCell.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class PositionCell: UITableViewCell {
    
    static let reuseId = "PositionCell"
    static let adminReuseId = "AdminPositionCell"
    
    let titleLabel = UILabel(text: "Какой-то товар",
                             font: FontsLibrary.positionTextBold)
    let countLabel = UILabel(text: "23 шт.",
                             font: FontsLibrary.positionText)
    let priceLabel = UILabel(text: "20000 р.",
                             font: FontsLibrary.positionText)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [titleLabel,
                                        countLabel,
                                        priceLabel],
                                axis: .horizontal,
                                spacing: 8)
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stack.centerYAnchor.constraint(equalTo: centerYAnchor),
             stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
             stack.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        NSLayoutConstraint.activate(
            [countLabel.widthAnchor.constraint(equalToConstant: 60),
             priceLabel.widthAnchor.constraint(equalToConstant: 80),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
