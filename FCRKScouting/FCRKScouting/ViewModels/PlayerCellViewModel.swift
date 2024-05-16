//
//  PlayerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

import UIKit

protocol PlayerCellViewModelProtocol {
    var photo: UIImage? { get }
    var fullName: String { get }
    var ageDescription: String { get }
    var position: String { get }
}

final class PlayerCellViewModel: PlayerCellViewModelProtocol {

    private let player: Player
    
    var photo: UIImage? {
        guard let photo = player.photo else { return nil }
        return UIImage(data: photo)
    }
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
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
    
    private func getYear(from date: Date?) -> String? {
        guard let date else { return nil }
        let year = Calendar.current.component(.year, from: date)
        let lastTwoDigits = String(year).suffix(2)
        return "'" + lastTwoDigits
    }
    
    private func format(position: String?) -> String? {
        guard let position else { return nil }
        guard let value = Constants.Text.Positions(rawValue: position) else {
            return nil
        }
        return value.abbreviate()
    }
}
