//
//  Helper.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class Helper {
    
    static func tamicOff(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    static func addSub(views: [UIView], to superview: UIView) {
        
        for view in views {
            superview.addSubview(view)
        }
    }
    
    static func dateToStr(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
}

