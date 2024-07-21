//
//  PlayerMainCardViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

protocol PlayerMainCardViewModelProtocol {
    var photo: UIImage? { get }
    var fullName: String { get }
    var position: String { get }
    var age: String { get }
    var citizenship: String { get }
    var clubAndNationalTeam: String { get }
    var foot: String { get }
    var height: String { get }
    var weight: String { get }
    var generalInfo: String { get }
    var technique: String { get }
    var tactics: String { get }
    var qualities: String { get }
    var mental: String { get }
    var creator: String { get }
    var lastEdition: String { get }
    var isFavorite: Bool { get }
    func addPlayerToFavorites()
    func removePlayerFromFavorites()
}

final class PlayerMainCardViewModel: PlayerMainCardViewModelProtocol {
    
    private let player: Player
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var photo: UIImage? {
        guard let photo = player.photoData else { return nil }
        return UIImage(data: photo)
    }
    
    var fullName: String {
        player.fullName?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var position: String {
        player.position?.replacingOccurrences(of: " ", with: "\n") ?? ""
    }
    
    var age: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let birthDate = player.birthDate else { return "Не указан" }
        let formattedBirthDate = dateFormatter.string(from: birthDate)
        let ageComponents = Calendar.current.dateComponents(
            [.year],
            from: birthDate,
            to: Date())
        return "\(ageComponents.year ?? 0) (\(formattedBirthDate))"
    }
    
    var citizenship: String {
        player.citizenship ?? ""
    }
    
    var clubAndNationalTeam: String {
        "\(player.club ?? "") / \(player.nationalTeam ?? "")"
    }
    
    var foot: String {
        player.foot ?? ""
    }
    
    var height: String {
        guard let height = player.height, !height.isEmpty else {
            return "0.00 м"
        }
        return height + " м"
    }
    
    var weight: String {
        guard let weight = player.weight, !weight.isEmpty else {
            return "00.00 кг"
        }
        return weight + " кг"
    }
    
    var generalInfo: String {
        player.generalInfo ?? ""
    }
    
    var technique: String {
        player.technique ?? ""
    }
    
    var tactics: String {
        player.tactics ?? ""
    }
    
    var qualities: String {
        player.qualities ?? ""
    }
    
    var mental: String {
        player.mental ?? ""
    }
    
    var creator: String {
        guard let creator = player.creator else { return "" }
        return "Создал карточку: \(creator)"
    }
    
    var lastEdition: String {
        guard let lastEditor = player.lastEditor else { return "" }
        guard let updatedDate = player.updatedDate else { return "" }
        let abbreviatedName = abbreviate(fullName: lastEditor)
        let formattedUpdatedDate = dateFormatter.string(from: updatedDate)
        let lastEdition = abbreviatedName + " (\(formattedUpdatedDate))"
        return "Правки внес: \(lastEdition)"
    }
    
    var isFavorite: Bool {
        guard let currentUser = UserManager.shared.getCurrentUser(),
              let favorites = currentUser.favorites else {
            return false
        }
        return favorites.contains(player)
    }
    
    init(player: Player) {
        self.player = player
    }
    
    private func abbreviate(fullName: String) -> String {
        let components = fullName.components(separatedBy: " ")
        guard let abbreviatedName = fullName.first,
              let lastName = components.last else { return "" }
        return String(abbreviatedName) + ". " + lastName
    }
    
    func addPlayerToFavorites() {
        StorageManager.shared.addFavoritePlayer(player)
    }
    
    func removePlayerFromFavorites() {
        StorageManager.shared.deleteFavoritePlayer(player)
    }
}
