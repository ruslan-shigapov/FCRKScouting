//
//  ProfileViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

protocol ProfileViewModelProtocol {
    var fullName: String { get }
    var access: String { get }
    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var isAddingAllowed: Bool {
        UserManager.shared.user?.isEditingAllowed ?? false
    }
    
    var fullName: String {
        UserManager.shared.user?.fullName ?? ""
    }
    
    var access: String {
        isAddingAllowed
        ? Constants.Text.editable
        : Constants.Text.onlyRead
    }
    
    func logOut() {
        UserManager.shared.deleteUser()
        ScreenFactory.setRootViewController()
    }
}
