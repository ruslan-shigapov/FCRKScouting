//
//  PlayerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

protocol PopoverViewControllerDelegate {
    var currentLeagueWasChosen: ((Int) -> Void)? { get set }
}

protocol PlayerCareerCardDelegate {
    var addCareerButtonWasTapped: (() -> Void)? { get set }
    var popoverButtonWasTapped: ((UIViewController) -> Void)? { get set }
}

protocol AddCareerViewControllerDelegate {
    var addCareerScreenWasClosed: (() -> Void)? { get set }
}
        
final class PlayerViewModel: CurrentUserProtocol,
                             EditorViewControllerDelegate,
                             PlayerCareerCardDelegate,
                             AddCareerViewControllerDelegate,
                             PopoverViewControllerDelegate {
    
    private let player: Player
    
    var onPlayersChanged: (() -> Void)?
    var addCareerButtonWasTapped: (() -> Void)?
    var addCareerScreenWasClosed: (() -> Void)?
    var popoverButtonWasTapped: ((UIViewController) -> Void)?
    var currentLeagueWasChosen: ((Int) -> Void)?
    
    var patronymic: String {
        player.patronymic ?? ""
    }
    
    init(player: Player) {
        self.player = player
    }
    
    func saveCurrentLeague(byValue value: Int) {
        let league = Constants.Texts.Leagues.allCases[value].rawValue
        StorageManager.shared.saveCurrentLeague(
            league,
            forPlayer: player.fullName ?? "")
    }
    
    func deletePlayer(completion: @escaping () -> Void) {
        guard let fullName = player.fullName else { return }
        StorageManager.shared.deletePlayer(byFullName: fullName) {
            completion()
        }
    }
    
    func getPlayer() -> Player {
        player
    }
    
    func getPlayerMainCardViewModel() -> PlayerMainCardViewModelProtocol {
        PlayerMainCardViewModel(player: player)
    }
    
    func getPlayerCareerCardViewModel() -> PlayerCareerCardViewModelProtocol {
        PlayerCareerCardViewModel(player: player)
    }
    
    func getPlayerExtraCardViewModel() -> PlayerExtraCardViewModelProtocol {
        PlayerExtraCardViewModel(player: player)
    }
}
