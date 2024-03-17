//
//  MainViewModel.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import Foundation

protocol MainViewModelProtocol {
    
}

final class MainViewModel: MainViewModelProtocol {
    
    private var user: User
    
    required init(user: User) {
        self.user = user
    }
}
