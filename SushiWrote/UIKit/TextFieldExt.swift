//
//  TextFieldExt.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, isShadow: Bool = true) {
        self.init(frame: CGRect())
        self.placeholder = placeholder
        self.font = FontsLibrary.fieldButton
        backgroundColor = .white
        layer.cornerRadius = 8
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 8))
        leftViewMode = .always
        
        if isShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
}
