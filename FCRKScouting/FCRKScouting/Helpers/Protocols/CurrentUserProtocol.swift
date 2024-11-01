//
//  CurrentUserProtocol.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

protocol CurrentUserProtocol {
    var isEditingAllowed: Bool { get }
    var userFullName: String { get }
}

extension CurrentUserProtocol {
    
    private var currentUser: User? {
        UserManager.shared.getCurrentUser()
    }
    
    var isEditingAllowed: Bool {
        currentUser?.isEditingAllowed ?? false
    }
    
    var userFullName: String {
        currentUser?.fullName ?? ""
    }
}


