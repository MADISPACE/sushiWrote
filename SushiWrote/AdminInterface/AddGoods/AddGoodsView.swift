//
//  AddGoodsView.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class AddGoodsView: UIView {

    let titleTF = UITextField(placeholder: "Название")
    let priceTF = UITextField(placeholder: "Цена")
    let descTF = UITextField(placeholder: "Описание")
    let imageView = UIImageView(image: UIImage(named: "sushi"))
    let picker = UIPickerView()
    let saveButton = UIButton(title: "Сохранить",
                              bgColor: ColorsLibrary.darkGreen,
                              textColor: .white,
                              font: FontsLibrary.fieldButton)
    
    init() {
        super.init(frame: CGRect())
        setViews()
        setConstraints()
    }
    
    func setViews() {
        
        backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        priceTF.keyboardType = .numberPad
    }
    
    func setConstraints() {
        
        let stack = UIStackView(views: [imageView, titleTF, priceTF, descTF, saveButton, picker],
                                axis: .vertical,
                                spacing: 12)
        
        Helper.addSub(views: [stack], to: self)
        Helper.tamicOff(views: [stack])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: topAnchor),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
                                     imageView.heightAnchor.constraint(equalToConstant: 200)
                                    ])
        
        
    }

    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






