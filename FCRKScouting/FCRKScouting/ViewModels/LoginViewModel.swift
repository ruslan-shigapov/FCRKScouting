//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

protocol LoginViewModelProtocol {
    var wasAccessKeyWrong: (() -> Void)? { get set }
    var wasSomethingWrong: (() -> Void)? { get set }
    func logIn(
        byAccessKey accessKey: String?,
        completion: @escaping (Bool) -> Void
    )
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var wasAccessKeyWrong: (() -> Void)?
    var wasSomethingWrong: (() -> Void)?
    
    func logIn(
        byAccessKey accessKey: String?,
        completion: @escaping (Bool) -> Void
    ) {
        guard let accessKey, !accessKey.isEmpty else { return }
        UserManager.shared.validateAccessKey(accessKey) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let isEditingAllowed):
                completion(isEditingAllowed)
            case .failure(let error):
                switch error {
                case .wrongKey:
                    wasAccessKeyWrong?()
                case .unknownError:
                    wasSomethingWrong?()
                }
            }
        }
    }
}
