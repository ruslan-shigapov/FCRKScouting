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
    
    func createUserWith(
        fullName: String,
        post: String,
        accessValue: Bool,
        completion: () -> Void
    ) {
        StorageManager.shared.saveUserWith(
            fullName: fullName,
            post: post,
            isEditingAllowed: accessValue
        ) {
            getUser()
            completion()
        }
    }
    
    func updateUser(
        fullName: String,
        post: String,
        completion: () -> Void
    ) {
        StorageManager.shared.updateUser(fullName: fullName, post: post) {
            getUser()
            completion()
        }
    }
    
    func deleteUser() {
        guard let fullName = user?.fullName else { return }
        StorageManager.shared.deleteUserBy(fullName)
        getUser()
    }
}
