//
//  UserViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

protocol UserViewModelProtocol {
    var isEditingAllowed: Bool { get }
    var fullName: String? { get }
}

extension UserViewModelProtocol {
    
    var isEditingAllowed: Bool {
        UserManager.shared.user?.isEditingAllowed ?? false
    }
    
    var fullName: String? {
        UserManager.shared.user?.fullName?.replacingOccurrences(
            of: " ",
            with: "\n"
        )
    }
}


