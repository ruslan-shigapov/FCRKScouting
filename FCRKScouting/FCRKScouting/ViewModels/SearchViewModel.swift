//
//  SearchViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

import Foundation

protocol SearchViewModelProtocol: UserViewModelProtocol,
                                  PlayerViewControllerDelegate {
    var isFiltersInactive: Bool { get }
    var hasNoResults: Bool { get }
    func findPlayers(byText text: String, completion: @escaping () -> Void)
    func returnOriginalPlayers()
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getNumberOfItems() -> Int
    func getPlayerCellViewModel(
        for player: Player?) -> PlayerCellViewModelProtocol?
    func toggleFilter(byTag tag: Int)
    func getRequiredPlayers()
    func cancelSearch()
}

final class SearchViewModel: SearchViewModelProtocol {
    
    private var filteredPlayers: Set<Player> = []
    private var foundPlayers: [Player] = []
    
    private var originalPlayers: [Player] = []
            
    private var isFavoritesButtonActive = false
    private var isRelatedButtonActive = false
    
    private var isSearchMode = false {
        didSet {
            originalPlayers = Array(filteredPlayers)
        }
    }
    
    var backButtonWasTapped: (() -> Void)?
    
    var isFiltersInactive: Bool {
        !isRelatedButtonActive && !isFavoritesButtonActive
    }
    
    var hasNoResults: Bool {
        isSearchMode
        ? foundPlayers.isEmpty
        : filteredPlayers.isEmpty
    }
    
    func findPlayers(byText text: String, completion: @escaping () -> Void) {
        isSearchMode = true
        if !isFiltersInactive {
            foundPlayers = filteredPlayers.filter {
                guard let fullName = $0.fullName else { return false }
                return fullName.lowercased().contains(text.lowercased())
            }
            completion()
        } else {
            StorageManager.shared.findPlayers(byText: text) { [weak self] in
                guard let self else { return }
                foundPlayers = $0
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func returnOriginalPlayers() {
        foundPlayers = originalPlayers
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        isSearchMode
        ? foundPlayers[indexPath.item]
        : Array(filteredPlayers)[indexPath.item]
    }
    
    func getNumberOfItems() -> Int {
        isSearchMode
        ? foundPlayers.count
        : filteredPlayers.count
    }
    
    func getPlayerCellViewModel(
        for player: Player?
    ) -> PlayerCellViewModelProtocol? {
        guard let player else { return nil }
        return PlayerCellViewModel(player: player)
    }
    
    func toggleFilter(byTag tag: Int) {
        if tag == 0 {
            isFavoritesButtonActive.toggle()
        } else if tag == 1 {
            isRelatedButtonActive.toggle()
        }
    }
    
    func getRequiredPlayers() {
        filteredPlayers.removeAll()
        if isFavoritesButtonActive {
            let currentUser = UserManager.shared.getCurrentUser()
            guard let favorites = currentUser?.favorites,
                  let favoritePlayers = favorites.allObjects as? [Player] else {
                return
            }
            filteredPlayers.formUnion(favoritePlayers)
        }
        if isRelatedButtonActive {
            StorageManager.shared.fetchRelatedPlayers(
                forUser: userFullName
            ) { [weak self] in
                guard let self else { return }
                filteredPlayers.formUnion($0)
            }
        }
    }
    
    func cancelSearch() {
        isSearchMode = false
        foundPlayers = []
    }
}
