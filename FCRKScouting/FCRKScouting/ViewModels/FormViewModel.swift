//
//  FormViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.05.2024.
//

protocol FormViewModelProtocol: TextFieldValidationProtocol {
    func enterBy(fullName: String, post: String, completion: () -> Void)
}

final class FormViewModel: FormViewModelProtocol {
    
    private let accessValue: Bool
    
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    
    required init(accessValue: Bool) {
        self.accessValue = accessValue
    }
    
    func enterBy(fullName: String, post: String, completion: () -> Void) {
        UserManager.shared.createUser(
            withFullName: fullName,
            post: post,
            accessValue: accessValue
        ) {
            completion()
        }
    }
}
