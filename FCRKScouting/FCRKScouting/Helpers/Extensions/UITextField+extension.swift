//
//  UITextField+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

extension UITextField {
    
    func setupAttributes(ofPlaceholder placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: Constants.Fonts.text,
                .foregroundColor: UIColor.lightGray
            ])
    }
    
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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            selectedTextRange = textRange(
                from: endOfDocument,
                to: endOfDocument)
        }
    }
}
