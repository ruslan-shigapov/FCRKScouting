//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import Foundation

protocol UpdatesViewModelProtocol: UserViewModelProtocol {
    var players: [Player] { get }
    var playersByDate: [String: [Player]] { get }
    var uniqueDates: [String] { get }
    func getNumberOfSections() -> Int
    func getNumberOfItemsInSection() -> Int
    func getPlayerCellViewModel(
        at indexPath: IndexPath) -> PlayerCellViewModelProtocol
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
    
    // TODO: докрутить логику преобразования там, где это требуется
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var players: [Player] = []
    
    var playersByDate: [String: [Player]] {
        Dictionary(grouping: players) {
            let formattedDate = dateFormatter.string(
                from: $0.updatedDate! // TODO: не забудь нормально извлечь и ниже
            )
            return formattedDate
        }
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
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModelProtocol {
        let date = uniqueDates[indexPath.section]
        return PlayerCellViewModel(
            player: playersByDate[date]![indexPath.item]
        )
    }
}
