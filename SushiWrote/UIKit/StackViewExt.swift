//
//  StackViewExt.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

extension UIStackView {
    
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat) {
        
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
    }
    
}
