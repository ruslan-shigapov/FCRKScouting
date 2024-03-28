//
//  ProfileViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import Foundation

protocol ProfileViewModelProtocol {
    var fullName: String { get }
    var access: String { get }
    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var fullName: String {
        user.fullName ?? ""
    }
    
    var access: String {
        user.isEditAllowed
        ? Constants.Text.editIsAllowed
        : Constants.Text.onlyRead
    }
    
    private var user: User
    
    required init(user: User) {
        self.user = user
    }
    
    func logOut() {
        UserManager.shared.deleteUser()
        ScreenFactory.setRootViewController()
    }
}
