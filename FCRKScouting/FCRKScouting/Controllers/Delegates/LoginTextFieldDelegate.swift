//
//  LoginTextFieldDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class LoginTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if let text = textField.text {
            let length = text.count + string.count - range.length
            if length > 6 { return false }
        }
        return true
    }
}
