//
//  PlayerCareerCardViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.07.2024.
//

import Foundation

protocol PlayerCareerCardViewModelProtocol {
    var fullName: String { get }
    func getNumberOfRows() -> Int
    func getCareerCellViewModel(
        at indexPath: IndexPath) -> CareerCellViewModelProtocol
}

final class PlayerCareerCardViewModel: PlayerCareerCardViewModelProtocol {
    
    private let player: Player
    
    private var careers: [Career] = [] // TODO: sort by year 
    
    var fullName: String {
        let components = player.fullName?.components(separatedBy: " ") ?? []
        let reversedFullName = "\(components[1]) \(components[0])"
        if let patronymic = player.patronymic {
            return "\(reversedFullName) \(patronymic)"
        }
        return reversedFullName
    }
    
    init(player: Player) {
        self.player = player
    }
    
    func getNumberOfRows() -> Int {
        careers.count
    }
    
    func getCareerCellViewModel(
        at indexPath: IndexPath
    ) -> CareerCellViewModelProtocol {
        CareerCellViewModel(career: careers[indexPath.row])
    }
}
