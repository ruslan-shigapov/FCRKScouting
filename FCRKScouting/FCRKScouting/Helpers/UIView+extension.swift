//
//  UIView+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import UIKit

extension UIView {
    
    func setCustomCornerRadius() {
        layer.cornerRadius = 12
    }
    
    func setCustomShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 10, height: -10)
    }
}
