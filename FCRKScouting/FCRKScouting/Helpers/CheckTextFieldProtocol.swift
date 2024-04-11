//
//  CheckTextFieldProtocol.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

protocol CheckTextFieldProtocol {
    var wasAnyTextFieldEmpty: (() -> Void)? { get set }
    var wasFullNameIncorrect: (() -> Void)? { get set }
    func validateInput(
        fullName: String?,
        accessKey: String?,
        completion: (String, String) -> Void
    )
}

extension CheckTextFieldProtocol {
    
    private func checkCorrectnessOf(fullName: String?) -> Bool {
        let components = fullName?.components(
            separatedBy: .whitespacesAndNewlines)
        let words = components?.filter { !$0.isEmpty }
        return words?.count == 2
    }
    
    func validateInput(
        fullName: String?,
        accessKey: String?,
        completion: (String, String) -> Void
    ) {
        if fullName == "" || accessKey == "" {
            wasAnyTextFieldEmpty?()
        } else if !checkCorrectnessOf(fullName: fullName) {
            wasFullNameIncorrect?()
        } else if let fullName, let accessKey {
            completion(fullName, accessKey)
        }
    }
}
