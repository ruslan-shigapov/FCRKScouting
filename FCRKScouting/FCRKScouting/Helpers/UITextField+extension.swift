//
//  UITextField+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

extension UITextField {
    
    func focusNextResponder() {
        if let nextTF = superview?.superview?.superview?.viewWithTag(
            tag + 1
        ) as? UITextField {
            nextTF.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
    }
    
    func moveCursorToEnd() {
        DispatchQueue.main.async {
            self.selectedTextRange = self.textRange(
                from: self.endOfDocument,
                to: self.endOfDocument)
        }
    }
}
