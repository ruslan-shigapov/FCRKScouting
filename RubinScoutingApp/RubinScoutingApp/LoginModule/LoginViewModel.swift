//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

import Foundation

protocol LoginViewModelProtocol {
    var wasAnyTextFieldEmpty: (() -> Void)? { get set }
    var wasAccessKeyWrong: (() -> Void)? { get set }
    var user: User? { get }
    func validateInput(
        name: String?,
        surname: String?,
        accessKey: String?,
        completion: (String, String, String) -> Void
    )
    func logIn(
        byName name: String,
        surname: String,
        accessKey: String,
        completion: () -> Void
    )
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var wasAnyTextFieldEmpty: (() -> Void)?
    var wasAccessKeyWrong: (() -> Void)?
    
    var user: User? {
        UserManager.shared.user
    }
    
    func validateInput(
        name: String?,
        surname: String?,
        accessKey: String?,
        completion: (String, String, String) -> Void
    ) {
        if name == "" || surname == "" || accessKey == "" {
            wasAnyTextFieldEmpty?()
        } else if let name, let surname, let accessKey {
            completion(name, surname, accessKey)
        }
    }
        
    func logIn(
        byName name: String,
        surname: String,
        accessKey: String,
        completion: () -> Void
    ) {
        UserManager.shared.createUser(
            withName: name,
            andSurname: surname,
            byAccessKey: accessKey
        ) {
            wasAccessKeyWrong?()
        }
        completion()
    }
}
