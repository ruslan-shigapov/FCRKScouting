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
    func getSortedCareers(completion: @escaping (() -> Void))
    func getCareerCellViewModel(
        at indexPath: IndexPath) -> CareerCellViewModelProtocol
    func deleteCareer(at indexPath: IndexPath)
}

final class PlayerCareerCardViewModel: PlayerCareerCardViewModelProtocol {
    
    private let player: Player
    
    private var careers: [Career] = []
    
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

    func getSortedCareers(completion: @escaping (() -> Void)) {
        guard let careers = player.careers?.allObjects as? [Career] else {
            return
        }
        let sortedCareers = careers.sorted(by: {
            guard let firstYear = $0.year, let secondYear = $1.year else {
                return false
            }
            guard let shortenedFirstYear = Int(firstYear.suffix(2)),
                  let shortenedSecondYear = Int(secondYear.suffix(2)) else {
                return false
            }
            return shortenedFirstYear > shortenedSecondYear
        })
        self.careers = sortedCareers
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        careers.count
    }
    
    func getCareerCellViewModel(
        at indexPath: IndexPath
    ) -> CareerCellViewModelProtocol {
        CareerCellViewModel(career: careers[indexPath.row])
    }
    
    func deleteCareer(at indexPath: IndexPath) {
        let deletedCareer = careers.remove(at: indexPath.row)
        StorageManager.shared.deleteCareer(deletedCareer, forPlayer: player)
    }
}
