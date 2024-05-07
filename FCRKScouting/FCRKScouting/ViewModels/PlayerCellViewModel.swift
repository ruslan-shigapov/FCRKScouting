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
        guard let age = getAge(from: player.birthDate) else { return "" }
        return String(age) // TODO: потом добавить лет, год и тд
    }
    
    var position: String {
        format(position: player.position) ?? ""
    }
    
    required init(player: Player) {
        self.player = player
    }
    
    private func getAge(from birthDate: Date?) -> Int? {
        guard let birthDate else { return nil }
        let ageComponents = Calendar.current.dateComponents(
            [.year],
            from: birthDate,
            to: Date()
        )
        return ageComponents.year
    }
    
    private func format(position: String?) -> String? {
        guard let position else { return nil }
        guard let value = Constants.Text.Positions(rawValue: position) else {
            return nil
        }
        return value.abbreviate()
    }
}
