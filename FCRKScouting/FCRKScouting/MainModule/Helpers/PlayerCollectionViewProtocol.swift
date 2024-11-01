//
//  PlayerCollectionViewProtocol.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.10.2024.
//

import Foundation

protocol PlayerViewControllerDelegate: AnyObject {
    var onPlayersPossiblyChanged: (() -> Void)? { get set }
}

protocol PlayerCollectionViewProtocol: PlayerViewControllerDelegate {
    func getNumberOfSections() -> Int
    func getNumberOfItems(in section: Int) -> Int
    func getPlayerCellViewModel(for player: Player?) -> PlayerCellViewModel?
    func getPlayer(at indexPath: IndexPath) -> Player?
    func getPlayerViewModel(for player: Player?) -> PlayerViewModel?
}

extension PlayerCollectionViewProtocol {
    
    func getPlayerCellViewModel(for player: Player?) -> PlayerCellViewModel? {
        guard let player else { return nil }
        return PlayerCellViewModel(player: player)
    }
    
    func getPlayerViewModel(for player: Player?) -> PlayerViewModel? {
        guard let player else { return nil }
        return PlayerViewModel(player: player)
    }
}
