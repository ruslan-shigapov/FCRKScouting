//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

protocol UpdatesViewModelProtocol {
    var isAddingAllowed: Bool { get }
    var players: [Player] { get }
    var playersByDate: [String: [Player]] { get }
    var uniqueDates: [String] { get }
    func getNumberOfSections() -> Int
    func getNumberOfItemsInSection() -> Int
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
            
    var isAddingAllowed: Bool {
        UserManager.shared.user?.isEditingAllowed ?? false
    }
    
    var players: [Player] = []
    
    var playersByDate: [String: [Player]] {
        Dictionary(grouping: players) { $0.updatedDate ?? "Дата неизвестна" }
    }
    
    var uniqueDates: [String] {
        Array(playersByDate.keys)
    }
        
    init() {
        fetchPlayers()
    }
    
    private func fetchPlayers() {
        StorageManager.shared.fetchPlayers { players = $0 }
    }
    
    func getNumberOfSections() -> Int {
        playersByDate.keys.count
    }
    
    func getNumberOfItemsInSection() -> Int {
        playersByDate.values.count
    }
}
