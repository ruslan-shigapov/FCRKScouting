//
//  MainTabBarViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

import Foundation

protocol MainTabBarViewModelProtocol {
    var user: User { get }
}

final class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    var user: User
    
    required init(user: User) {
        self.user = user
    }
}
