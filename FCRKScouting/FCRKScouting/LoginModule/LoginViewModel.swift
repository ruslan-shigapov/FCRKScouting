//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

protocol LoginViewModelProtocol: CheckTextFieldProtocol {
    var wasAccessKeyWrong: (() -> Void)? { get set }
    var didReceiveDataError: (() -> Void)? { get set }
    func signUp(
        byFullName fullName: String,
        accessKey: String,
        completion: () -> Void
    )
    func logIn(completion: (User) -> Void)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var wasAnyTextFieldEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    var wasAccessKeyWrong: (() -> Void)?
    var didReceiveDataError: (() -> Void)?
        
    func signUp(
        byFullName fullName: String,
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
    
    func logIn(completion: (User) -> Void) {
        if let user = UserManager.shared.user {
            completion(user)
        } else {
            didReceiveDataError?()
        }
    }
}
