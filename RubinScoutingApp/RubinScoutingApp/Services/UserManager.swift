//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import Foundation

private enum AccessType: String {
    case readOnly = "332211"
    case editable = "220888"
}

final class UserManager {
    
    static let shared = UserManager()
    
    var user: User?
    
    private init() {
        getUser()
    }
    
    func createUser(
        withName name: String,
        andSurname surname: String,
        byAccessKey accessKey: String,
        completion: () -> Void
    ) {
        guard accessKey == AccessType.readOnly.rawValue ||
              accessKey == AccessType.editable.rawValue else {
            completion()
            return
        }
        StorageManager.shared.saveUser(
            withName: name,
            surname: surname,
            access: accessKey == AccessType.editable.rawValue)
        getUser()
    }
    
    private func getUser() {
        StorageManager.shared.fetchUser { user = $0 }
    }
}
