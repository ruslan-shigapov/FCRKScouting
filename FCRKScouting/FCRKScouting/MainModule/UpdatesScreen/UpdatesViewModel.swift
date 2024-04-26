//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

protocol UpdatesViewModelProtocol {
    var isAddingAllowed: Bool { get }
    var players: [Player] { get }
    func getNumberOfSections() -> Int
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
    
    var isAddingAllowed: Bool {
        user.isEditAllowed
    }
    
    var players: [Player] = []
    
    func getNumberOfSections() -> Int {
        1
    }
    
    private var user: User
    
    required init(user: User) {
        self.user = user
        fetchPlayers()
    }
    
    private func fetchPlayers() {
        StorageManager.shared.fetchPlayers { players = $0 }
    }
}
