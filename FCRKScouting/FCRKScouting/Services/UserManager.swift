//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import Foundation

enum AccessError: Error {
    case wrongKey
}

final class UserManager {
    
    static let shared = UserManager()
    
    private let accessLevels = [
        "200458": false, // readOnly
        "220888": true   // editingAllowed
    ]
    
    private var currentUser: User? {
        didSet {
            UserDefaults.standard.set(currentUser?.appleID, forKey: "appleID")
        }
    }

    private init() {
        loadCurrentUser()
    }
    
    private func loadCurrentUser() {
        if let appleID = UserDefaults.standard.string(forKey: "appleID") {
            StorageManager.shared.findUser(appleID) { [weak self] in
                guard let self else { return }
                currentUser = $0
            }
        }
    }
    
    func getCurrentUser() -> User? {
        currentUser
    }
    
    func validateAccessKey(
        _ accessKey: String?,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        guard let accessKey, !accessKey.isEmpty,
              let isEditingAllowed = accessLevels[accessKey] else {
            completion(.failure(AccessError.wrongKey))
            return
        }
        completion(.success(isEditingAllowed))
    }
    
    func setCurrentUser(_ user: User) {
        currentUser = user
    }
    
    func createUser(
        _ appleID: String,
        fullName: String,
        isEditingAllowed: Bool
    ) {
        StorageManager.shared.saveUser(
            byAppleID: appleID,
            fullName: fullName,
            isEditingAllowed: isEditingAllowed
        ) { [weak self] createdUser in
            guard let self else { return }
            if let createdUser {
                currentUser = createdUser
            }
        }
    }
    
    func updateCurrentUserFullName(
        _ fullName: String,
        completion: @escaping () -> Void
    ) {
        guard let appleID = currentUser?.appleID else { return }
        StorageManager.shared.renameUser(
            appleID,
            toFullName: fullName
        ) { [weak self] updatedUser in
            guard let self else { return }
            if let updatedUser {
                currentUser = updatedUser
                completion()
            }
        }
    }
    
    func clearCurrentUser(completion: @escaping () -> Void) {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "appleID")
        completion()
    }
}
