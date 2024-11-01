//
//  TournamentViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 25.09.2024.
//

import Foundation

protocol ResponsibleListViewControllerDelegate: AnyObject {
    var responsibleOneWasChosen: (() -> Void)? { get set }
}

protocol ResponsibleCellDelegate: AnyObject {
    var responsibleOneWasDeleted: ((User) -> Void)? { get set }
}

protocol TournamentViewModelProtocol: PlayerViewControllerDelegate,
                                      EditorViewControllerDelegate,
                                      ResponsibleListViewControllerDelegate,
                                      ResponsibleCellDelegate {
    var isDeletingModeActive: Bool { get set }
    var name: String { get }
    var age: String { get }
    var date: String { get }
    var place: String { get }
    var onSendingFailed: (() -> Void)? { get set }
    var isPlayersForViewingEmpty: Bool { get }
    func getNumberOfResponsibleOnes() -> Int
    func getResponsibleCellViewModel(
        at indexPath: IndexPath
    ) -> ResponsibleCellViewModelProtocol?
    func fetchPlayersForViewing(completion: @escaping () -> Void)
    func deleteTournament(completion: @escaping () -> Void)
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getNumberOfItems() -> Int
    func getPlayerCellViewModel(at indexPath: IndexPath) -> PlayerCellViewModel
    func getTournament() -> Tournament
    func deleteResponsibleOne(
        _ scout: User,
        completion: @escaping () -> Void
    )
    func getPlayerViewModel(at indexPath: IndexPath) -> PlayerViewModel?
    func sendTask(completion: @escaping () -> Void)
}

final class TournamentViewModel: TournamentViewModelProtocol {
            
    private let tournament: Tournament
    
    private var playersForViewing: [Player] = []
    
    var isDeletingModeActive = false
    
    var onPlayersPossiblyChanged: (() -> Void)?
    var onPlayersChanged: (() -> Void)?
    var responsibleOneWasChosen: (() -> Void)?
    var responsibleOneWasDeleted: ((User) -> Void)?
    var onSendingFailed: (() -> Void)?

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
    
    func getNumberOfResponsibleOnes() -> Int {
        guard let responsibleOnes = tournament.responsibleOnes,
              let scouts = responsibleOnes.allObjects as? [User] else {
            return 0
        }
        return scouts.count
    }
    
    func getResponsibleCellViewModel(
        at indexPath: IndexPath
    ) -> ResponsibleCellViewModelProtocol? {
        guard let responsibleOnes = tournament.responsibleOnes,
              let scouts = responsibleOnes.allObjects as? [User] else {
            return nil
        }
        return ResponsibleCellViewModel(scout: scouts[indexPath.item])
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
    
    func getPlayerViewModel(at indexPath: IndexPath) -> PlayerViewModel? {
        guard let player = getPlayer(at: indexPath) else { return nil }
        return PlayerViewModel(player: player)
    }
    
    func getPlayerCellViewModel(
        at indexPath: IndexPath
    ) -> PlayerCellViewModel {
        PlayerCellViewModel(player: playersForViewing[indexPath.item])
    }
    
    func getTournament() -> Tournament {
        tournament
    }
    
    func deleteResponsibleOne(
        _ scout: User,
        completion: @escaping () -> Void
    ) {
        StorageManager.shared.deleteResponsibleOne(
            scout,
            fromTournament: tournament)
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func sendTask(completion: @escaping () -> Void) {
        NetworkManager.shared.sendTask(
            withPlayers: playersForViewing
        ) { [weak self] in
            guard let self else { return }
            switch $0 {
            case .success:
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.onSendingFailed?()
                }
            }
        }
    }
}
