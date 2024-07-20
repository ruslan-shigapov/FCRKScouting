//
//  AddCareerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.07.2024.
//

import Foundation

protocol AddCareerViewModelProtocol {
    var wasRatioOfYearsWrong: (() -> Void)? { get set }
    var years: [Int] { get }
    func saveCareer(
        forYear year: Int,
        toYear: Int?,
        league: Int,
        coach: String,
        completion: @escaping () -> Void
    )
    func checkRatioOf(year: Int, andYear toYear: Int, completion: () -> Void)
}

final class AddCareerViewModel: AddCareerViewModelProtocol {
    
    private let player: Player
    
    var wasRatioOfYearsWrong: (() -> Void)?
    
    var years: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let years = Array(2000...currentYear)
        return years.reversed()
    }
    
    init(player: Player) {
        self.player = player
    }
    
    func saveCareer(
        forYear year: Int,
        toYear: Int?,
        league: Int,
        coach: String,
        completion: @escaping () -> Void
    ) {
        let period = toYear == nil
        ? String(years[year])
        : "\(years[year] % 100)/\(years[toYear ?? 0] % 100)"
        let league = Constants.Text.Leagues.allCases[league].rawValue
        StorageManager.shared.addCareer(
            forPlayer: player.fullName ?? "",
            forPeriod: period,
            league: league,
            coach: coach)
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func checkRatioOf(year: Int, andYear toYear: Int, completion: () -> Void) {
        guard year > toYear else {
            wasRatioOfYearsWrong?()
            return
        }
        completion()
    }
}
