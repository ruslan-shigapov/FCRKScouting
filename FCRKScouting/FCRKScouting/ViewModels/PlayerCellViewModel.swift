//
//  PlayerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

import Foundation

protocol PlayerCellViewModelProtocol {
    var fullName: String { get }
    var ageDescription: String { get }
    var position: String { get }
}

final class PlayerCellViewModel: PlayerCellViewModelProtocol {

    private let player: Player
    
    var fullName: String {
        player.fullName ?? ""
    }
    
    var ageDescription: String {
        getYear(from: player.birthDate) ?? ""
    }
    
    var position: String {
        format(position: player.position) ?? ""
    }
    
    required init(player: Player) {
        self.player = player
    }
    
    func getYear(from date: Date?) -> String? {
        guard let date else { return nil }
        let year = Calendar.current.component(.year, from: date)
        return String(year)
    }
    
    private func format(position: String?) -> String? {
        guard let position else { return nil }
        guard let value = Constants.Text.Positions(rawValue: position) else {
            return nil
        }
        return value.abbreviate()
    }
}
