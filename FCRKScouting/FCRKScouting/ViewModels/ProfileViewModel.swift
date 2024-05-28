//
//  ProfileViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

protocol FormViewControllerDelegate {
    var userWasUpdated: (() -> Void)? { get set }
}

protocol ProfileViewModelProtocol: UserViewModelProtocol,
                                   FormViewControllerDelegate {
    var access: String { get }
    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var userWasUpdated: (() -> Void)?
    
    var access: String {
        isEditingAllowed
        ? Constants.Text.editable
        : Constants.Text.onlyRead
    }
    
    func logOut() {
        UserManager.shared.deleteUser()
        ScreenFactory.setRootViewController()
    }
}
