//
//  TournamentCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.09.2024.
//

import Foundation

protocol TournamentCellViewModelProtocol {
    var name: String { get }
    var dateAndPlace: String { get }
    var age: String { get }
}

final class TournamentCellViewModel: TournamentCellViewModelProtocol {
    
    private let tournament: Tournament
    
    var name: String {
        tournament.name ?? ""
    }
    
    var dateAndPlace: String {
        guard let startDate = tournament.startDate,
              let endDate = tournament.endDate,
              let place = tournament.place else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let startMonth = dateFormatter.string(from: startDate)
        let endMonth = dateFormatter.string(from: endDate)
        let startDay = Calendar.current.component(.day, from: startDate)
        let endDay = Calendar.current.component(.day, from: endDate)
        if startMonth == endMonth {
            if startDay == endDay {
                return "\(startDay) \(startMonth), \(place)"
            }
            return "\(startDay)-\(endDay) \(startMonth), \(place)"
        }
        return "\(startDay) \(startMonth) - \(endDay) \(endMonth), \(place)"
    }
    
    var age: String {
        guard let age = tournament.age else { return "" }
        return age.replacingOccurrences(of: "-", with: "\n-")
    }
    
    init(tournament: Tournament) {
        self.tournament = tournament
    }
}
