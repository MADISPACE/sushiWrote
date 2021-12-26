//
//  ButtonExt.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     bgColor: UIColor,
                     textColor: UIColor,
                     font: UIFont?) {
        self.init(type: .system)
        
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        tintColor = textColor
        titleLabel?.font = font!
        layer.cornerRadius = 8
        
    }
    
}
