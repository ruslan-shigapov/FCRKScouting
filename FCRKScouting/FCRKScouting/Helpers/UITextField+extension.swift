//
//  UITextField+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

extension UITextField {
    
    func focusNextResponder() {
        if let nextTF = self.superview?.superview?.superview?.viewWithTag(
            self.tag + 1) as? UITextField {
            nextTF.becomeFirstResponder()
        } else {
            self.resignFirstResponder()
        }
    }
    
    
}
