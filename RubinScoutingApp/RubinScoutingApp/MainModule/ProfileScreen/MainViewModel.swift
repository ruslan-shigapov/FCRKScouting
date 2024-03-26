//
//  MainViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import Foundation

protocol MainViewModelProtocol {
    var fullName: String { get }
}

final class MainViewModel: MainViewModelProtocol {
    
    var fullName: String {
        user.fullName ?? ""
    }
    
    private var user: User
    
    required init(user: User) {
        self.user = user
    }
}
