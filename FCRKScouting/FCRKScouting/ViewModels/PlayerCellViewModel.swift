//
//  PlayerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.05.2024.
//

import UIKit

protocol PlayerCellViewModelProtocol: AnyObject {
    var photo: UIImage? { get }
    var fullName: String { get }
    var ageDescription: String { get }
    var position: String { get }
}

final class PlayerCellViewModel: PlayerCellViewModelProtocol {
    
    private let player: Player
        
    var photo: UIImage? {
        guard let photo = player.photoData else { return nil }
        return UIImage(data: photo)
    }
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var ageDescription: String {
        getYear(fromDate: player.birthDate) ?? "???"
    }
    
    var position: String {
        guard let position = player.position else { return "" }
        return position.formatToShortPosition()
    }
    
    init(player: Player) {
        self.player = player
    }
    
    private func getYear(fromDate date: Date?) -> String? {
        guard let date else { return nil }
        let year = Calendar.current.component(.year, from: date)
        return String(year)
    }
}
