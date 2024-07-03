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
    var wasFullNameContainInvalidChars: (() -> Void)? { get set }
}

extension TextFieldValidationProtocol {
    
    private func getCorrectFullName(fromText text: String) -> String? {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = trimmedText.components(
            separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        guard components.count == 2 else { return nil }
        for component in components {
            if !component.unicodeScalars.allSatisfy({
                CharacterSet.letters.contains($0)
            }) {
                return nil
            }
        }
        return components.joined(separator: " ")
    }
    
    func validateInputText(
        _ text: [String],
        completion: ([String]) -> Void
    ) {
        guard text.allSatisfy({ !$0.isEmpty }) else {
            wereRequiredTextFieldsEmpty?()
            return
        } 
        guard let correctFullName = getCorrectFullName(fromText: text[0]) else {
            wasFullNameIncorrect?()
            return
        }
        guard correctFullName.range(
            of: "^[А-Яа-яЁё\\s]+$", options: .regularExpression) != nil else {
            wasFullNameContainInvalidChars?()
            return
        }
        let correctedText = text.enumerated().map {
            $0 == 0 ? correctFullName : $1
        }
        completion(correctedText)
    }
}
