//
//  AuthManager.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.06.2024.
//

import AuthenticationServices

final class AuthManager: NSObject {
    
    private var isEditingAllowed: Bool
    
    private var completionHandler: ((Result<Bool, Error>) -> Void)?
    
    init(isEditingAllowed: Bool) {
        self.isEditingAllowed = isEditingAllowed
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
    
    func singInWithApple(completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName]
        let controller = ASAuthorizationController(
            authorizationRequests: [request])
        controller.performRequests()
        controller.delegate = self
        completionHandler = completion
    }
}

// MARK: - ASAuthorization Controller Delegate
extension AuthManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        let credential = authorization.credential
        if let credential = credential as? ASAuthorizationAppleIDCredential {
            StorageManager.shared.findUser(credential.user) { [weak self] in
                guard let self else { return }
                if let matchedUser = $0 {
                    UserManager.shared.setCurrentUser(matchedUser)
                    completionHandler?(.success(false))
                } else {
                    UserManager.shared.createUser(
                        credential.user,
                        fullName: getUserFullNameFrom(credential.fullName),
                        isEditingAllowed: isEditingAllowed
                    )
                    completionHandler?(.success(true))
                }
            }
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        completionHandler?(.failure(error))
    }
}
