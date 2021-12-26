//
//  LabelExt.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?) {
        self.init(frame: CGRect())
        self.text = text
        self.font = font
    }
}
