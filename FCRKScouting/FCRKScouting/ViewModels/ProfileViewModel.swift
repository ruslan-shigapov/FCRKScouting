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
    var profileFullName: String { get }
    var access: String { get }
    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var userWasUpdated: (() -> Void)?
    
    var profileFullName: String {
        userFullName.replacingOccurrences(of: " ", with: "\n")
    }
    
    var access: String {
        isEditingAllowed
        ? Constants.Texts.editable
        : Constants.Texts.onlyRead
    }
    
    func logOut() {
        UserManager.shared.clearCurrentUser { [weak self] in
            guard let _ = self else { return }
            ScreenFactory.setRootViewController()
        }
    }
}
