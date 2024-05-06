//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

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
    
    private func getUser() {
        StorageManager.shared.fetchUser { user = $0 }
    }
    
    func createUser(
        withFullName fullName: String,
        byAccessKey accessKey: String,
        completion: () -> Void
    ) {
        guard accessKey == AccessType.readOnly.rawValue ||
              accessKey == AccessType.editable.rawValue else {
            completion()
            return
        }
        StorageManager.shared.saveUser(
            withFullName: fullName,
            isEditingAllowed: accessKey == AccessType.editable.rawValue)
        getUser()
    }
    
    func deleteUser() {
        StorageManager.shared.deleteUsers()
        getUser()
    }
}
