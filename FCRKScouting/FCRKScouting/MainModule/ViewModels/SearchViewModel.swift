//
//  SearchViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.04.2024.
//

import Foundation

protocol FiltersViewControllerDelegate {
    var positionValue: Int { get set }
    var leagueValue: Int { get set }
    var footValue: Int { get set }
    var ageValue: String? { get set }
    var toAgeValue: String? { get set }
    var onExtraFiltersChanged: (() -> Void)? { get set }
}

final class SearchViewModel: CurrentUserProtocol,
                             FiltersViewControllerDelegate {
    
    // MARK: Private Properties
    private var foundPlayers: [Player] = []
    
    private var filteredPlayers: Set<Player> = []
    
    private var originalPlayers: [Player] = []
    
    private var isFavoritesButtonActive = false
    private var isRelatedButtonActive = false
    
    private var isSearchMode = false {
        didSet {
            originalPlayers = Array(filteredPlayers)
        }
    }
    
    // MARK: Public Properties
    var positionValue = 0
    var leagueValue = 0
    var footValue = 0
    var ageValue: String?
    var toAgeValue: String?
    
    var onExtraFiltersChanged: (() -> Void)?
    var onSearchTextChanged: (() -> Void)?
    var onSearchTextCleared: (() -> Void)?
    var onSearchResultsUpdated: ((Bool) -> Void)?
    var onPlayersPossiblyChanged: (() -> Void)?

    var isFiltersInactive: Bool {
        !isRelatedButtonActive && !isFavoritesButtonActive
    }
    
    var hasNoResults: Bool {
        isSearchMode
        ? foundPlayers.isEmpty
        : filteredPlayers.isEmpty
    }
        
    var extraFiltersValue = false
    
    // MARK: Private Methods
    private func filterByExtraParameters(_ players: any Sequence<Player>) {
        guard extraFiltersValue else { return }
        let extraFilteredPlayers = players.filter {
            var isMatched = true
            if positionValue > 0 {
                let position = Constants.Texts.Positions.allCases[positionValue]
                isMatched = $0.position == position.rawValue
            }
            if leagueValue > 0 {
                let league = Constants.Texts.Leagues.allCases[leagueValue]
                isMatched = isMatched && $0.currentLeague == league.rawValue
            }
            if footValue > 0 {
                let feet = Constants.Texts.SegmentedControlItems.footSegments
                isMatched = isMatched && $0.foot == feet[footValue - 1]
            }
            if let ageValue, !ageValue.isEmpty, let playerAge = getAge(ofPlayer: $0) {
                if let toAgeValue,
                   !toAgeValue.isEmpty,
                   let age = Int(ageValue),
                   let toAge = Int(toAgeValue) {
                    let isInRange = playerAge >= age && playerAge <= toAge
                    isMatched = isMatched && isInRange
                } else {
                    isMatched = isMatched && playerAge == Int(ageValue)
                }
            }
            return isMatched
        }
        if isSearchMode {
            foundPlayers = extraFilteredPlayers
        } else {
            filteredPlayers = filteredPlayers.intersection(extraFilteredPlayers)
        }
    }
    
    private func getAge(ofPlayer player: Player) -> Int? {
        guard let birthDate = player.birthDate else { return nil }
        let ageComponents = Calendar.current.dateComponents(
            [.year],
            from: birthDate,
            to: Date())
        return ageComponents.year
    }
    
    // MARK: Public Methods
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
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModel? {
        guard let player = getPlayer(at: indexPath) else { return nil }
        return PlayerCellViewModel(player: player)
    }
    
    func getPlayerViewModel(at indexPath: IndexPath) -> PlayerViewModel? {
        guard let player = getPlayer(at: indexPath) else { return nil }
        return PlayerViewModel(player: player)
    }
    
    func toggleFilter(byTag tag: Int) {
        if tag == 1 {
            isRelatedButtonActive.toggle()
        } else if tag == 2 {
            isFavoritesButtonActive.toggle()
        }
    }
    
    func getRequiredPlayers() {
        filteredPlayers.removeAll()
        if isFavoritesButtonActive && !isRelatedButtonActive {
            let currentUser = UserManager.shared.getCurrentUser()
            guard let favorites = currentUser?.favorites as? Set<Player> else {
                return
            }
            filteredPlayers.formUnion(favorites)
            filterByExtraParameters(filteredPlayers)
        } else if isRelatedButtonActive && !isFavoritesButtonActive {
            StorageManager.shared.fetchRelatedPlayers(
                forUser: userFullName
            ) { [weak self] in
                guard let self else { return }
                filteredPlayers.formUnion($0)
                filterByExtraParameters(filteredPlayers)
            }
        } else if isRelatedButtonActive && isFavoritesButtonActive {
            let currentUser = UserManager.shared.getCurrentUser()
            guard let favorites = currentUser?.favorites as? Set<Player> else {
                return
            }
            StorageManager.shared.fetchRelatedPlayers(
                forUser: userFullName
            ) { [weak self] in
                guard let self else { return }
                filteredPlayers = favorites.intersection($0)
                filterByExtraParameters(filteredPlayers)
            }
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

// MARK: - PlayerCollectionViewProtocol
extension SearchViewModel: PlayerCollectionViewProtocol {
    
    func getNumberOfSections() -> Int {
        1
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        isSearchMode
        ? foundPlayers.count
        : filteredPlayers.count
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        isSearchMode
        ? foundPlayers[indexPath.item]
        : Array(filteredPlayers)[indexPath.item]
    }
}
