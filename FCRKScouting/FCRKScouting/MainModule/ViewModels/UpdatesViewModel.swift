//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import Foundation

protocol EditorViewControllerDelegate {
    var onPlayersChanged: (() -> Void)? { get set }
}

final class UpdatesViewModel: CurrentUserProtocol,
                              EditorViewControllerDelegate {
    
    // MARK: Private Properties
    private var players: [Player] = []
    
    private var filteredPlayersByDate: [Date: [Player]] = [:]
    
    private var groupedPlayersByDate: [Date: [Player]] {
        Dictionary(grouping: players) {
            Calendar.current.startOfDay(for: $0.updatedDate ?? Date())
        }
        .mapValues { $0.reversed() }
    }
    
    private var sortedDates: [Date] {
        filteredPlayersByDate.keys.sorted(by: <)
    }
    
    // MARK: Public Properties
    var onPlayersChanged: (() -> Void)?
    var onPlayersPossiblyChanged: (() -> Void)?
    
    var currentInterval: Int = 0 {
        didSet {
            filterPlayersByDate()
        }
    }
    
    var hasNoResults: Bool {
        filteredPlayersByDate.isEmpty
    }
      
    // MARK: Initialize
    init() {
        StorageManager.shared.fetchPlayers() { [weak self] in
            guard let self else { return }
            players = $0
            filterPlayersByDate()
        }
    }
    
    // MARK: Private Methods
    private func filterPlayersByDate() {
        if currentInterval == 1 {
            let startDate = Calendar.current.date(
                byAdding: .weekOfYear,
                value: -1,
                to: Date())
            filteredPlayersByDate = groupedPlayersByDate.filter { date, _ in
                date >= startDate ?? Date()
            }
        } else if currentInterval == 2 {
            let startDate = Calendar.current.date(
                byAdding: .month,
                value: -1,
                to: Date())
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

    // MARK: Public Methods 
    func getFormattedDate(at index: Int) -> String {
        sortedDates[index].format()
    }
    
    func fetchPlayers(completion: @escaping () -> Void) {
        StorageManager.shared.fetchPlayers() { [weak self] in
            guard let self else { return }
            players = $0
            filterPlayersByDate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
            }
        }
    }
    
    func syncWithDatabase(completion: @escaping () -> Void) {
        StorageManager.shared.fetchPlayersFromCloud {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

// MARK: - PlayerCollectionViewProtocol
extension UpdatesViewModel: PlayerCollectionViewProtocol {
    
    func getNumberOfSections() -> Int {
        filteredPlayersByDate.count
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        let sectionDate = sortedDates[section]
        return filteredPlayersByDate[sectionDate]?.count ?? 0
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        guard indexPath.section < sortedDates.count else { return nil }
        let sectionDate = sortedDates[indexPath.section]
        guard let playersInSection = filteredPlayersByDate[sectionDate],
              indexPath.item < playersInSection.count else {
            return nil
        }
        return playersInSection[indexPath.item]
    }
}
