//
//  SearchViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

protocol SearchViewModelProtocol {
    
}

final class SearchViewModel: SearchViewModelProtocol {
    
    private var user: User
    
    required init(user: User) {
        self.user = user
    }
}
