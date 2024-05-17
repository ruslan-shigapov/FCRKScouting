//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import Foundation

protocol PlayerAddingViewControllerDelegate {
    var playerWasAdded: (() -> Void)? { get set }
}

protocol UpdatesViewModelProtocol: UserViewModelProtocol, 
                                   PlayerAddingViewControllerDelegate {
    var currentInterval: Int { get set }
    var sortedDates: [Date] { get }
    func getNumberOfSections() -> Int
    func getNumberOfItemsIn(_ section: Int) -> Int
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModelProtocol?
    func format(_ date: Date) -> String
    func refreshPlayers(completion: () -> Void)
}

final class UpdatesViewModel: UpdatesViewModelProtocol {
    
    private var players: [Player] = []
    
    private var groupedPlayersByDate: [Date: [Player]] {
        Dictionary(grouping: players) {
            Calendar.current.startOfDay(for: $0.updatedDate ?? Date())
        }
        .mapValues { $0.reversed() }
    }
    
    private var filteredPlayersByDate: [Date: [Player]] = [:]
    
    var playerWasAdded: (() -> Void)?
    
    var currentInterval: Int = 0 {
        didSet {
            filterPlayersByDate()
        }
    }
    
    var sortedDates: [Date] {
        filteredPlayersByDate.keys.sorted(by: <)
    }
            
    init() {
        fetchPlayers()
        filterPlayersByDate()
    }
    
    private func fetchPlayers() {
        StorageManager.shared.fetchPlayers { players = $0 }
    }
    
    private func filterPlayersByDate() {
        if currentInterval == 1 {
            let startDate = Calendar.current.date(
                byAdding: .weekOfYear,
                value: -1,
                to: Date()
            )
            filteredPlayersByDate = groupedPlayersByDate.filter { date, _ in
                date >= startDate ?? Date()
            }
        } else if currentInterval == 2 {
            let startDate = Calendar.current.date(
                byAdding: .month,
                value: -1,
                to: Date()
            )
            filteredPlayersByDate = groupedPlayersByDate.filter { date, _ in
                date >= startDate ?? Date()
            }
        } else {
            let startDate = Calendar.current.startOfDay(for: Date())
            filteredPlayersByDate = groupedPlayersByDate.filter { date, _ in
                date == startDate
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        filteredPlayersByDate.count
    }
    
    func getNumberOfItemsIn(_ section: Int) -> Int {
        let sectionDate = sortedDates[section]
        return filteredPlayersByDate[sectionDate]?.count ?? 0
    }
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModelProtocol? {
        guard indexPath.section < sortedDates.count else { return nil }
        let sectionDate = sortedDates[indexPath.section]
        guard let playersInSection = filteredPlayersByDate[sectionDate] else {
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
    
    func refreshPlayers(completion: () -> Void) {
        fetchPlayers()
        filterPlayersByDate()
        completion()
    }
}
