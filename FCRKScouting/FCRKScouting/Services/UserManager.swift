//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

final class UserManager {
    
    static let shared = UserManager()
    
    private let accessLevels = [
        "332211": false, // readOnly
        "220888": true   // editable
    ]
    
    var user: User?
    
    private init() {
        getUser()
    }
    
    private func getUser() {
        StorageManager.shared.fetchUser { user = $0 }
    }
    
    func createUser(
        withFullName fullName: String,
        byAccessKey accessKey: String,
        completion: () -> Void
    ) {
        guard let isEditable = accessLevels[accessKey] else {
            completion()
            return
        }
        StorageManager.shared.saveUser(
            withFullName: fullName,
            isEditingAllowed: isEditable
        )
        getUser()
    }
    
    func deleteUser() {
        StorageManager.shared.deleteUsers()
        getUser()
    }
}
