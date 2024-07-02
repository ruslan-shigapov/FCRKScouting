//
//  UserViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

protocol UserViewModelProtocol {
    var isEditingAllowed: Bool { get }
    var userFullName: String { get }
}

extension UserViewModelProtocol {
    
    var isEditingAllowed: Bool {
        UserManager.shared.getCurrentUser()?.isEditingAllowed ?? false
    }
    
    var userFullName: String {
        UserManager.shared.getCurrentUser()?.fullName ?? ""
//        UserManager.shared.getCurrentUser()?.fullName?.replacingOccurrences(
//            of: " ",
//            with: "\n")
    }
}


