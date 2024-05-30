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
        guard let currentText = textField.text as NSString? else { return true }
        let newString = currentText.replacingCharacters(in: range, with: string)
        if newString.count > 6 {
            return false
        }
        return true
    }
}
