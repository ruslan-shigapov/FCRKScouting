//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

import Foundation

protocol LoginViewModelProtocol {
//    func checkInput(text: [String?], completion: () -> Void) -> [String]
    func logIn(
        byName name: String,
        surname: String,
        accessKey: String,
        completion: @escaping () -> Void
    )
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var user: User?
    
//    func checkInput(text: [String?], completion: () -> Void) -> [String] {
//        text.map {
//            guard $0 != nil else {
//                completion()
//            }
//        }
//    }
    
    func logIn(
        byName name: String,
        surname: String,
        accessKey: String,
        completion: @escaping () -> Void
    ) {
        UserManager.shared.createUser(
            withName: name,
            andSurname: surname,
            byAccessKey: accessKey
        ) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(_):
                completion()
            }
        }
    }
}
