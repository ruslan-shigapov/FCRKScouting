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
        withName name: String,
        andSurname surname: String,
        byAccessKey accessKey: String,
        completion: @escaping (Result<User, LoginError>) -> Void
    ) {
        guard accessKey == "220888" || accessKey == "654321" else {
            completion(.failure(.wrongKey))
            return
        }
        var user = User(name: name, surname: surname)
        if accessKey == "220888" {
            user.access = .editable
        }
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        completion(.success(user))
    }
}
