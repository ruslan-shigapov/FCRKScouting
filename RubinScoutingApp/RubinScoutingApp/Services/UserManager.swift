//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import Foundation

enum LoginError: Error {
    case wrongKey
}

final class UserManager {
    
    static let shared = UserManager()
        
    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    private init() {}
    
    func createUser(
        withName firstName: String,
        andSurname secondName: String,
        byAccessKey accessKey: String,
        completion: @escaping (Result<User, LoginError>) -> Void
    ) {
        guard accessKey == "220888" else {
            completion(.failure(.wrongKey))
            return
        }
        let user = User(firstName: firstName, secondName: secondName)
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        completion(.success(user))
    }
}
