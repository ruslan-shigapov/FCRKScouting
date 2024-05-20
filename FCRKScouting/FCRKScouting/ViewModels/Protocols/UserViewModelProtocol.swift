//
//  UserViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

protocol UserViewModelProtocol {
    var isEditingAllowed: Bool { get }
    var fullName: String? { get }
    var post: String { get }
}

extension UserViewModelProtocol {
    
    var isEditingAllowed: Bool {
        UserManager.shared.user?.isEditingAllowed ?? false
    }
    
    var fullName: String? {
        UserManager.shared.user?.fullName?.replacingOccurrences(
            of: " ",
            with: "\n")
    }
    
    var post: String {
        guard let certainPost = UserManager.shared.user?.post,
              !certainPost.isEmpty else {
            return Constants.Text.notSpecified
        }
        return certainPost
    }
}


