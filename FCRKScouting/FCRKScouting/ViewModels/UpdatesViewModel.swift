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
    func getNumberOfItemsIn(_ section: Int) -> Int
    func getPlayerCellViewModel(
        at indexPath: IndexPath) -> PlayerCellViewModelProtocol?
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var players: [Player] = []
    
    var playersByDate: [String: [Player]] {
        Dictionary(grouping: players) {
            if let date = $0.updatedDate {
                let formattedDate = dateFormatter.string(from: date)
                return formattedDate
            } else {
                return "Дата неизвестна"
            }
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
    
    func getNumberOfItemsIn(_ section: Int) -> Int {
        let date = uniqueDates[section]
        return playersByDate[date]?.count ?? 0
    }
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModelProtocol? {
        let date = uniqueDates[indexPath.section]
        let playersForDate = playersByDate[date]?[indexPath.item]
        return playersForDate.map { PlayerCellViewModel(player: $0) }
    }
}
