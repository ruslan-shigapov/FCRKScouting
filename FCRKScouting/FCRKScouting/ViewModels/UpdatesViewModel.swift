//
//  UpdatesViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import Foundation

protocol EditorViewControllerDelegate {
    var playersWereChanged: (() -> Void)? { get set }
}

protocol PlayerViewControllerDelegate {
    var backButtonWasTapped: (() -> Void)? { get set }
}

protocol UpdatesViewModelProtocol: UserViewModelProtocol,
                                   EditorViewControllerDelegate,
                                   PlayerViewControllerDelegate {
    var currentInterval: Int { get set }
    var sortedDates: [Date] { get }
    var hasNoResults: Bool { get }
    func getNumberOfSections() -> Int
    func getNumberOfItemsIn(_ section: Int) -> Int
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getPlayerCellViewModel(
        for player: Player?) -> PlayerCellViewModelProtocol?
    func getPlayerViewModel(
        for player: Player?) -> PlayerViewModelProtocol?
    func format(date: Date) -> String
    func refreshPlayersList(completion: @escaping () -> Void)
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
    
    var playersWereChanged: (() -> Void)?
    var backButtonWasTapped: (() -> Void)?
    
    var currentInterval: Int = 0 {
        didSet {
            filterPlayersByDate()
        }
    }
    
    var sortedDates: [Date] {
        filteredPlayersByDate.keys.sorted(by: <)
    }
    
    var hasNoResults: Bool {
        filteredPlayersByDate.isEmpty
    }
            
    init() {
        StorageManager.shared.fetchPlayers() { [weak self] in
            guard let self else { return }
            players = $0
            filterPlayersByDate()
        }
    }
    
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
    
    func getNumberOfSections() -> Int {
        filteredPlayersByDate.count
    }
    
    func getNumberOfItemsIn(_ section: Int) -> Int {
        let sectionDate = sortedDates[section]
        return filteredPlayersByDate[sectionDate]?.count ?? 0
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        guard indexPath.section < sortedDates.count else { return nil }
        let sectionDate = sortedDates[indexPath.section]
        guard let playersInSection = filteredPlayersByDate[sectionDate] else {
            return nil
        }
        guard indexPath.item < playersInSection.count else { return nil }
        return playersInSection[indexPath.item]
    }
    
    func getPlayerCellViewModel(
        for player: Player?
    ) -> PlayerCellViewModelProtocol? {
        guard let player else { return nil }
        return PlayerCellViewModel(player: player)
    }
    
    func getPlayerViewModel(
        for player: Player?
    ) -> PlayerViewModelProtocol? {
        guard let player else { return nil }
        return PlayerViewModel(player: player)
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func refreshPlayersList(completion: @escaping () -> Void) {
        StorageManager.shared.fetchPlayers() { [weak self] in
            guard let self else { return }
            players = $0
            filterPlayersByDate()
            completion()
        }
    }
}
