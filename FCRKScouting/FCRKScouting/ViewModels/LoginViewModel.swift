//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

protocol LoginViewModelProtocol: TextFieldValidationProtocol {
    var wasAccessKeyWrong: (() -> Void)? { get set }
    var didReceiveDataError: (() -> Void)? { get set }
    func signUpBy(
        fullName: String,
        accessKey: String,
        completion: () -> Void
    )
    func logIn(completion: () -> Void)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var wasAnyTextFieldEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    var wasAccessKeyWrong: (() -> Void)?
    var didReceiveDataError: (() -> Void)?
        
    func signUpBy(
        fullName: String,
        accessKey: String,
        completion: () -> Void
    ) {
        UserManager.shared.createUser(
            withFullName: fullName,
            byAccessKey: accessKey
        ) {
            wasAccessKeyWrong?()
        }
        completion()
    }
    
    func logIn(completion: () -> Void) {
        if UserManager.shared.user != nil {
            completion()
        } else {
            didReceiveDataError?()
        }
    }
}
