//
//  LoginViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 06.03.2024.
//

final class LoginViewModel {
    
    var wasAccessKeyWrong: (() -> Void)?
    var wasSomethingWrong: (() -> Void)?
    
    func logIn(
        byAccessKey accessKey: String,
        completion: @escaping (Bool) -> Void
    ) {
        UserManager.shared.validateAccessKey(accessKey) { [weak self] in
            guard let self else { return }
            switch $0 {
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
