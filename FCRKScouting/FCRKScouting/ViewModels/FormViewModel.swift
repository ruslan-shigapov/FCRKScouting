//
//  FormViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.05.2024.
//

protocol FormViewModelProtocol: TextFieldValidationProtocol {
    var fullName: String? { get }
    var post: String? { get }
    func saveUserBy(
        fullName: String,
        post: String,
        completion: (_ isEditing: Bool) -> Void)
}

final class FormViewModel: FormViewModelProtocol {
    
    private let accessValue: Bool

    var fullName: String? {
        UserManager.shared.user?.fullName
    }
    var post: String? {
        UserManager.shared.user?.post
    }
    
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    
    init(accessValue: Bool) {
        self.accessValue = accessValue
    }
    
    func saveUserBy(
        fullName: String,
        post: String,
        completion: (_ isEditingMode: Bool) -> Void
    ) {
        if let _ = self.fullName {
            UserManager.shared.updateUser(fullName: fullName, post: post) {
                completion(true)
            }
        } else {
            UserManager.shared.createUserWith(
                fullName: fullName,
                post: post,
                accessValue: accessValue
            ) {
                completion(false)
            }
        }
    }
 }
