//
//  FormViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.05.2024.
//

protocol FormViewModelProtocol: UserViewModelProtocol,
                                TextFieldValidationProtocol {
    func saveUserBy(
        fullName: String,
        completion: (_ isEditing: Bool) -> Void)
}

final class FormViewModel: FormViewModelProtocol {

    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    
    func saveUserBy(
        fullName: String,
        completion: (_ isEditingMode: Bool) -> Void
    ) {
//        if let _ = self.fullName {
//            UserManager.shared.updateUser(fullName: fullName, post: post) {
//                completion(true)
//            }
//        } else {
//            UserManager.shared.createUserWith(
//                fullName: fullName,
//                post: post,
//                accessValue: accessValue
//            ) {
//                completion(false)
//            }
//        }
    }
 }
