//
//  TextFieldValidationProtocol.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import Foundation

protocol TextFieldValidationProtocol {
    var wereRequiredTextFieldsEmpty: (() -> Void)? { get set }
    var wasFullNameIncorrect: (() -> Void)? { get set }
}

extension TextFieldValidationProtocol {
    
    private func getCorrect(fullName: String) -> String? {
        let trimmedText = fullName.trimmingCharacters(
            in: .whitespacesAndNewlines)
        let components = trimmedText.components(
            separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        guard components.count == 2 else { return nil }
        for component in components {
            if !component.unicodeScalars.allSatisfy({
                CharacterSet.letters.contains($0)}) { return nil }
        }
        return components.joined(separator: " ")
    }
    
    func validateInput(
        text: [String],
        completion: ([String]) -> Void
    ) {
        guard text.allSatisfy({ !$0.isEmpty }) else {
            wereRequiredTextFieldsEmpty?()
            return
        } 
        guard let correctedFullName = getCorrect(fullName: text[0]) else {
            wasFullNameIncorrect?()
            return
        }
        let correctedText = text.enumerated().map {
            $0 == 0 ? correctedFullName : $1
        }
        completion(correctedText)
    }
}
