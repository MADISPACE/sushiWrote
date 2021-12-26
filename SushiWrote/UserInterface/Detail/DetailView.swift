//
//  DetailView.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class DetailView: UIView {
    
    let imageView = UIImageView(image: UIImage(named:"sushi"))
    let titleLabel = UILabel(text: "Название продукта",
                             font: FontsLibrary.smallTitle)
    let priceLabel = UILabel(text: "3500 р.",
                             font: FontsLibrary.fieldButton)
    let descrTextView = UITextView()
    let addToCartButton = UIButton(title: "В корзину",
                                   bgColor: ColorsLibrary.redButton,
                                   textColor: .white,
                                   font: FontsLibrary.fieldButton)
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setViews()
        setConstraints()
    }
    
    func setViews() {
        descrTextView.text = "бла бла бла бла бла бла бал ба лаб ал ба ла бала"
        descrTextView.font = FontsLibrary.cellText
        descrTextView.isEditable = false
    }
    
    func setConstraints() {
        
        let stack = UIStackView(views: [titleLabel,
                                        priceLabel,
                                        descrTextView,
                                        addToCartButton],
                                axis: .vertical,
                                spacing: 12)
        
        Helper.addSub(views: [stack, imageView], to: self)
        Helper.tamicOff(views: [stack,
                                imageView,
                                titleLabel,
                                priceLabel,
                                descrTextView,
                                addToCartButton])
        
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
                                    ])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                                     descrTextView.heightAnchor.constraint(equalToConstant: 50),
                                     addToCartButton.heightAnchor.constraint(equalToConstant: 40)
                                    ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
