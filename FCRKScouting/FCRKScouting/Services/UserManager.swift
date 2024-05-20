//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

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
        post: String,
        accessValue: Bool,
        completion: () -> Void
    ) {
        StorageManager.shared.saveUser(
            withFullName: fullName,
            post: post,
            isEditingAllowed: accessValue
        ) {
            getUser()
            completion()
        }
    }
    
    func deleteUser() {
        // TODO: удалять только текущего пользователя
        StorageManager.shared.deleteUsers()
        getUser()
    }
}
