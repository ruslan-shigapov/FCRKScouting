//
//  SearchViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

import Foundation

protocol SearchViewModelProtocol: UserViewModelProtocol,
                                  PlayerViewControllerDelegate {
    var hasNoResults: Bool { get }
    func findPlayers(byText text: String, completion: @escaping () -> Void)
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getNumberOfItems() -> Int
    func getPlayerCellViewModel(
        for player: Player?) -> PlayerCellViewModelProtocol?
    func cancelSearch()
    func getRelatedPlayers()
}

final class SearchViewModel: SearchViewModelProtocol {
    
    private var filteredPlayers: [Player] = []
    
    var backButtonWasTapped: (() -> Void)?
    
    var hasNoResults: Bool {
        filteredPlayers.isEmpty
    }
    
    func findPlayers(byText text: String, completion: @escaping () -> Void) {
        StorageManager.shared.findPlayers(byText: text) { [weak self] in
            guard let self else { return }
            filteredPlayers = $0
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        filteredPlayers[indexPath.item]
    }
    
    func getNumberOfItems() -> Int {
        filteredPlayers.count
    }
    
    func getPlayerCellViewModel(
        for player: Player?
    ) -> PlayerCellViewModelProtocol? {
        guard let player else { return nil }
        return PlayerCellViewModel(player: player)
    }
    
    func cancelSearch() {
        filteredPlayers = []
    }
    
    func getRelatedPlayers() {
        StorageManager.shared.fetchRelatedPlayers(
            forUser: userFullName
        ) { [weak self] in
            guard let self else { return }
            filteredPlayers = $0
        }
    }
}
