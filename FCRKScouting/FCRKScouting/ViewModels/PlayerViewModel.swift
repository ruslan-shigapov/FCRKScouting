//
//  PlayerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

protocol PlayerViewModelProtocol: UserViewModelProtocol,
                                  EditorViewControllerDelegate {
    var fullName: String { get }
    var position: String { get }
    var birthDate: String { get }
    var citizenship: String { get }
    var clubAndNationalTeam: String { get }
    var foot: String { get }
    var generalInfo: String { get }
    var creator: String { get }
    var lastEditor: String { get }
    func getPlayer() -> Player
    func deletePlayer()
}

final class PlayerViewModel: PlayerViewModelProtocol {
        
    private let player: Player
    
    var playersWereChanged: (() -> Void)?
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var position: String {
        player.position?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var birthDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedBirthDate = formatter.string(from: player.birthDate!)
        let ageComponents = Calendar.current.dateComponents([.year], from: player.birthDate!, to: Date())
        return "\(formattedBirthDate) (\(ageComponents.year ?? 0))"
    }
    
    var citizenship: String {
        player.citizenship ?? ""
    }
    
    var clubAndNationalTeam: String {
        "\(player.club ?? "") / \(player.nationalTeam ?? "")"
    }
    
    var generalInfo: String {
        player.generalInfo ?? ""
    }
    
    var foot: String {
        player.foot ?? ""
    }
    
    var creator: String {
        "Создал карточку: \(player.creator ?? "")"
    }
    
    var lastEditor: String {
        "Посл. изменения внёс: \(player.lastEditor ?? "")"
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
