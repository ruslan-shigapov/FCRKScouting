//
//  UserManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import AuthenticationServices

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
    
    private func getUserFullNameFrom(
        _ personNameComponents: PersonNameComponents?
    ) -> String {
        guard let firstName = personNameComponents?.givenName,
              let secondName = personNameComponents?.familyName else {
            return ""
        }
        return firstName + " " + secondName
    }
    
    private func createUser(
        _ appleID: String,
        fullName: String,
        isEditingAllowed: Bool
    ) {
        StorageManager.shared.saveUser(
            byAppleID: appleID,
            fullName: fullName,
            isEditingAllowed: isEditingAllowed
        ) { [weak self] in
            guard let self, let createdUser = $0 else { return }
            currentUser = createdUser
        }
    }
    
    func getCurrentUser() -> User? {
        currentUser
    }
    
    func validateAccessKey(
        _ accessKey: String?,
        completion: @escaping (Result<Bool, AccessError>) -> Void
    ) {
        guard let accessKey, !accessKey.isEmpty,
              let isEditingAllowed = accessLevels[accessKey] else {
            completion(.failure(.wrongKey))
            return
        }
        completion(.success(isEditingAllowed))
    }
    
    func setUser(
        by credential: ASAuthorizationAppleIDCredential,
        isEditingAllowed: Bool,
        completion: @escaping (_ isNewUser: Bool) -> Void
    ) {
        StorageManager.shared.findUserFromCloud(
            byAppleID: credential.user
        ) { [weak self] in
            guard let self else { return }
            if let foundUser = $0 {
                currentUser = foundUser
                completion(false)
            } else {
                createUser(
                    credential.user,
                    fullName: getUserFullNameFrom(credential.fullName),
                    isEditingAllowed: isEditingAllowed)
                completion(true)
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
        ) { [weak self] in
            guard let self, let updatedUser = $0 else { return }
            currentUser = updatedUser
            completion()
        }
    }
    
    func clearCurrentUser(completion: @escaping () -> Void) {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "appleID")
        completion()
    }
}
