//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

protocol LoginViewModelProtocol {
    var wasAccessKeyWrong: (() -> Void)? { get set }
    func logInBy(accessKey: String, completion: (Bool) -> Void)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private let accessLevels = [
        "200458": false, // readOnly
        "220888": true   // editable
    ]
    
    var wasAccessKeyWrong: (() -> Void)?
    
    func logInBy(accessKey: String, completion: (Bool) -> Void) {
        if accessKey.isEmpty { return }
        guard let isEditable = accessLevels[accessKey] else {
            wasAccessKeyWrong?()
            return
        }
        completion(isEditable)
    }
}
