//
//  SearchViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

import Foundation

protocol FiltersViewControllerDelegate {
    var position: Int { get set }
    var league: Int { get set }
    var foot: Int { get set }
    var age: String? { get set }
    var toAge: String? { get set }
    var extraFiltersWareChanged: (() -> Void)? { get set }
}

protocol SearchViewModelProtocol: UserViewModelProtocol,
                                  PlayerViewControllerDelegate,
                                  FiltersViewControllerDelegate {
    var isFiltersInactive: Bool { get }
    var hasNoResults: Bool { get }
    var extraFiltersValue: Bool { get set }
    func findPlayers(byText text: String, completion: @escaping () -> Void)
    func returnOriginalPlayers()
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getNumberOfItems() -> Int
    func getPlayerCellViewModel(
        for player: Player?) -> PlayerCellViewModelProtocol?
    func toggleFilter(byTag tag: Int)
    func getRequiredPlayers()
    func cancelSearch()
    func getFiltersViewModel() -> FiltersViewModelProtocol?
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
    var extraFiltersWareChanged: (() -> Void)?
    
    var position = 0
    var league = 0
    var foot = 0
    var age: String?
    var toAge: String?
    
    var isFiltersInactive: Bool {
        !isRelatedButtonActive && !isFavoritesButtonActive
    }
    
    var hasNoResults: Bool {
        isSearchMode
        ? foundPlayers.isEmpty
        : filteredPlayers.isEmpty
    }
        
    var extraFiltersValue = false
    
    func findPlayers(byText text: String, completion: @escaping () -> Void) {
        isSearchMode = true
        if !isFiltersInactive {
            foundPlayers = filteredPlayers.filter {
                guard let fullName = $0.fullName else { return false }
                return fullName.lowercased().contains(text.lowercased())
            }
            if extraFiltersValue == true {
                filterByExtraParameters(foundPlayers)
            }
            completion()
        } else {
            StorageManager.shared.findPlayers(byText: text) { [weak self] in
                guard let self else { return }
                foundPlayers = $0
                if extraFiltersValue == true {
                    filterByExtraParameters(foundPlayers)
                }
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
            filterByExtraParameters(filteredPlayers)
        } else if isRelatedButtonActive {
            StorageManager.shared.fetchRelatedPlayers(
                forUser: userFullName
            ) { [weak self] in
                guard let self else { return }
                filteredPlayers.formUnion($0)
                filterByExtraParameters(filteredPlayers)
            }
        }
    }
    
    private func filterByExtraParameters(_ players: any Sequence<Player>) {
        guard extraFiltersValue else { return }
        let extraFilteredPlayers = players.filter {
            var isMatched = true
            if position > 0 {
                let position = Constants.Text.Positions.allCases[position]
                isMatched = $0.position == position.rawValue
            }
            if league > 0 {
                let league = Constants.Text.Leagues.allCases[league]
                isMatched = isMatched && $0.currentLeague == league.rawValue
            }
            if foot > 0 {
                let feet = Constants.Text.SegmentedControlItems.footSegments
                isMatched = isMatched && $0.foot == feet[foot - 1]
            }
            if let age, !age.isEmpty, toAge == nil || toAge == "" {
                // TODO: закончить логику
            }
            if let age, let toAge, !age.isEmpty, !toAge.isEmpty {
                
            }
            return isMatched
        }
        if isSearchMode {
            foundPlayers = extraFilteredPlayers
        } else {
            filteredPlayers = filteredPlayers.intersection(extraFilteredPlayers)
        }
    }
    
    func cancelSearch() {
        isSearchMode = false
        foundPlayers = []
    }
    
    func getFiltersViewModel() -> FiltersViewModelProtocol? {
        FiltersViewModel(isFiltersActive: true)
    }
}
