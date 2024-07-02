//
//  PlayerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

protocol PlayerViewModelProtocol: UserViewModelProtocol,
                                  EditorViewControllerDelegate {
    var photo: UIImage? { get }
    var fullName: String { get }
    var patronymic: String { get }
    var position: String { get }
    var age: String { get }
    var citizenship: String { get }
    var clubAndNationalTeam: String { get }
    var foot: String { get }
    var height: String { get }
    var weight: String { get }
    var generalInfo: String { get }
    var creator: String { get }
    var lastEditor: String { get }
    func getPlayer() -> Player
    func deletePlayer()
}
        
//final class PlayerViewModel: PlayerViewModelProtocol {

final class PlayerViewModel: PlayerViewModelProtocol {
    
    private let player: Player
    
    var playersWereChanged: (() -> Void)?
    
    var photo: UIImage? {
        guard let photo = player.photo else { return nil }
        return UIImage(data: photo)
    }
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var patronymic: String {
        player.patronymic ?? ""
    }
    
    var position: String {
        player.position?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var age: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let birthDate = player.birthDate else { return "" }
        let formattedBirthDate = formatter.string(from: birthDate)
        let ageComponents = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
        return "\(ageComponents.year ?? 0) (\(formattedBirthDate))"
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
    
    var height: String {
        guard let height = player.height, !height.isEmpty else { return "" }
        return height + " м"
    }
    
    var weight: String {
        guard let weight = player.weight, !weight.isEmpty else { return "" }
        return weight + " кг"
    }
    
    var creator: String {
        guard let creator = player.creator else { return "" }
        return "Создал карточку: \(abbreviateNameIn(fullName: creator))"
    }
    
    var lastEditor: String {
        guard let lastEditor = player.lastEditor else { return "" }
        return "Посл. редактировал: \(abbreviateNameIn(fullName: lastEditor))"
    }
    
    init(player: Player) {
        self.player = player
    }
    
    private func abbreviateNameIn(fullName: String) -> String {
        let components = fullName.components(separatedBy: " ")
        guard let abbreviatedName = fullName.first,
              let lastName = components.last else { return "" }
        return String(abbreviatedName) + ". " + lastName
    }
    
    func getPlayer() -> Player {
        player
    }
    
    func deletePlayer() {
        guard let fullName = player.fullName else { return }
        StorageManager.shared.deletePlayerBy(fullName)
    }
}
