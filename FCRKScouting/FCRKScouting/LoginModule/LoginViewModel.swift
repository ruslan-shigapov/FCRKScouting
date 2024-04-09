//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

protocol LoginViewModelProtocol {
    var wasAnyTextFieldEmpty: (() -> Void)? { get set }
    var wasFullNameIncorrect: (() -> Void)? { get set }
    var wasAccessKeyWrong: (() -> Void)? { get set }
    var didReceiveDataError: (() -> Void)? { get set }
    func validateInput(
        fullName: String?,
        accessKey: String?,
        completion: (String, String) -> Void
    )
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
