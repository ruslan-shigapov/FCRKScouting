//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import Foundation

protocol UpdatesViewModelProtocol: UserViewModelProtocol {
    var sortedDates: [Date] { get }
    func getNumberOfSections() -> Int
    func getNumberOfItemsIn(_ section: Int) -> Int
    func getPlayerCellViewModel(
        at indexPath: IndexPath) -> PlayerCellViewModelProtocol?
    func format(_ date: Date) -> String
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
    
    private var players: [Player] = []
    
    private var sortedPlayersByDate: [Date: [Player]] {
        Dictionary(grouping: players) {
            Calendar.current.startOfDay(for: $0.updatedDate ?? Date())
        }
        .mapValues { $0.reversed() }
    }
    
    var sortedDates: [Date] {
        sortedPlayersByDate.keys.sorted()
    }
        
    init() {
        fetchPlayers()
    }
    
    private func fetchPlayers() {
        StorageManager.shared.fetchPlayers { players = $0 }
    }
    
    func getNumberOfSections() -> Int {
        sortedPlayersByDate.count
    }
    
    func getNumberOfItemsIn(_ section: Int) -> Int {
        let sectionDate = sortedDates[section]
        return sortedPlayersByDate[sectionDate]?.count ?? 0
    }
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModelProtocol? {
        guard indexPath.section < sortedDates.count else { return nil }
        let sectionDate = sortedDates[indexPath.section]
        guard let playersInSection = sortedPlayersByDate[sectionDate] else {
            return nil
        }
        guard indexPath.item < playersInSection.count else { return nil }
        let player = playersInSection[indexPath.item]
        return PlayerCellViewModel(player: player)
    }
    
    func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
