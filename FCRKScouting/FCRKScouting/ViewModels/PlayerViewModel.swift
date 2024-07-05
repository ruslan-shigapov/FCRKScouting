//
//  PlayerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

protocol PlayerViewModelProtocol: UserViewModelProtocol,
                                  EditorViewControllerDelegate {
    var patronymic: String { get }
    func deletePlayer()
    func getPlayer() -> Player
    func getMainPlayerCardViewModel() -> MainPlayerCardViewModelProtocol
}
        
final class PlayerViewModel: PlayerViewModelProtocol {
    
    private let player: Player
    
    var playersWereChanged: (() -> Void)?
    
    var patronymic: String {
        player.patronymic ?? ""
    }
    
    init(player: Player) {
        self.player = player
    }
    
    func deletePlayer() {
        guard let fullName = player.fullName else { return }
        StorageManager.shared.deletePlayer(byFullName: fullName)
    }
    
    func getPlayer() -> Player {
        player
    }
    
    func getMainPlayerCardViewModel() -> MainPlayerCardViewModelProtocol {
        MainPlayerCardViewModel(player: player)
    }
}
