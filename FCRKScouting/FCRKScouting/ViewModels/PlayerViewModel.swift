//
//  PlayerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

protocol PlayerViewModelProtocol: EditorViewControllerDelegate {
    var fullName: String { get }
    func getPlayer() -> Player
    func deletePlayer()
}

final class PlayerViewModel: PlayerViewModelProtocol {
        
    private let player: Player
    
    var playersWereChanged: (() -> Void)?
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    init(player: Player) {
        self.player = player
    }
    
    func getPlayer() -> Player {
        player
    }
    
    func deletePlayer() {
        guard let fullName = player.fullName else { return }
        StorageManager.shared.deletePlayerBy(fullName)
    }
}
