//
//  TextFieldValidationProtocol.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

protocol TextFieldValidationProtocol {
    var wasAnyTextFieldEmpty: (() -> Void)? { get set }
    var wasFullNameIncorrect: (() -> Void)? { get set }
    func validateInput(
        text: [String?],
        completion: ([String]) -> Void
    )
}

extension TextFieldValidationProtocol {
    
    private func checkEmptinessOf(text: [String?]) -> Bool {
        var isTextEmpty = false
        text.forEach {
            if $0 == "" {
                isTextEmpty = true
            }
        }
        return isTextEmpty
    }
    
    private func checkCorrectnessOf(fullName: String?) -> Bool {
        let components = fullName?.components(
            separatedBy: .whitespacesAndNewlines
        )
        let words = components?.filter { !$0.isEmpty }
        return words?.count == 2
    }
    
    func validateInput(
        text: [String?],
        completion: ([String]) -> Void
    ) {
        if checkEmptinessOf(text: text) {
            wasAnyTextFieldEmpty?()
        } else if !checkCorrectnessOf(fullName: text[0]) {
            wasFullNameIncorrect?()
        }
        completion(text.compactMap { $0 })
    }
}
