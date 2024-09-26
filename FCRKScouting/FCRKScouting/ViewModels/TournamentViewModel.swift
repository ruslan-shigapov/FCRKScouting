//
//  TournamentViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 25.09.2024.
//

import Foundation

protocol TournamentViewModelProtocol: PlayerViewControllerDelegate,
                                      EditorViewControllerDelegate {
    var name: String { get }
    var age: String { get }
    var date: String { get }
    var place: String { get }
    var isPlayersForViewingEmpty: Bool { get }
    func fetchPlayersForViewing(completion: @escaping () -> Void)
    func deleteTournament(completion: @escaping () -> Void)
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getNumberOfItems() -> Int
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModel
    func getTournament() -> Tournament
}

final class TournamentViewModel: TournamentViewModelProtocol {
        
    private let tournament: Tournament
    
    private var playersForViewing: [Player] = []
    
    var backButtonWasTapped: (() -> Void)?
    var playersWereChanged: (() -> Void)?

    var name: String {
        tournament.name ?? ""
    }
    
    var age: String {
        guard let age = tournament.age else { return "" }
        return "\(age) г.р."
    }
    
    var date: String {
        guard let startDate = tournament.startDate,
              let endDate = tournament.endDate else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let startMonth = dateFormatter.string(from: startDate)
        let endMonth = dateFormatter.string(from: endDate)
        let startDay = Calendar.current.component(.day, from: startDate)
        let endDay = Calendar.current.component(.day, from: endDate)
        if startMonth == endMonth {
            if startDay == endDay {
                return "\(startDay) \(startMonth)"
            }
            return "\(startDay)-\(endDay) \(startMonth)"
        }
        return "\(startDay) \(startMonth) - \(endDay) \(endMonth)"
    }
    
    var place: String {
        tournament.place ?? ""
    }
    
    var isPlayersForViewingEmpty: Bool {
        playersForViewing.isEmpty
    }
    
    init(tournament: Tournament) {
        self.tournament = tournament
    }
    
    func fetchPlayersForViewing(completion: @escaping () -> Void) {
        StorageManager.shared.fetchPlayers(
            forTournament: tournament
        ) { [weak self] in
            guard let self else { return }
            playersForViewing = $0
            completion()
        }
    }
    
    func deleteTournament(completion: @escaping () -> Void) {
        StorageManager.shared.deleteTournament(tournament)
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func getPlayer(at indexPath: IndexPath) -> Player? {
        playersForViewing[indexPath.item]
    }
    
    func getNumberOfItems() -> Int {
        playersForViewing.count
    }
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModel {
        PlayerCellViewModel(player: playersForViewing[indexPath.item])
    }
    
    func getTournament() -> Tournament {
        tournament
    }
}
