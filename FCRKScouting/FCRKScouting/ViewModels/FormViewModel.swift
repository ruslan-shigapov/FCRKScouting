//
//  FormViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.05.2024.
//

protocol FormViewModelProtocol: UserViewModelProtocol,
                                TextFieldValidationProtocol {
    func saveUserFullName(_ fullName: String, completion: @escaping () -> Void)
}

final class FormViewModel: FormViewModelProtocol {
    
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    
    func saveUserFullName(
        _ fullName: String,
        completion: @escaping () -> Void
    ) {
        UserManager.shared.updateCurrentUserFullName(fullName) {
            completion()
        }
    }
}
