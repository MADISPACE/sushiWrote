//
//  DetailAdminView.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class DetailAdminView: UIView {

    let tableView = UITableView()
    let dateLabel = UILabel(text: "26.12.2021", font: FontsLibrary.fieldButton)
    let nameLabel = UILabel(text: "Федя Курочкин", font: FontsLibrary.fieldButton)
    let phoneLabel = UILabel(text: "+7 9998887766", font: FontsLibrary.fieldButton)
    
    let statusPicker = UIPickerView()
    
    let saveButton = UIButton(title: "Сохранить", bgColor: ColorsLibrary.darkGreen, textColor: .white, font: FontsLibrary.fieldButton)
    
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setConstraints()
        
        self.tableView.register(PositionCell.self,
                                forCellReuseIdentifier: PositionCell.adminReuseId)
        
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [nameLabel,
                                        phoneLabel,
                                        dateLabel,
                                        tableView,
                                        saveButton,
                                        statusPicker,
                                        ],
                                axis: .vertical,
                                spacing: 16)
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stack.topAnchor.constraint(equalTo: topAnchor, constant: 80),
             stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
             stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
             stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
             saveButton.heightAnchor.constraint(equalToConstant: 42)
//             statusPicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -30)
            ])
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
