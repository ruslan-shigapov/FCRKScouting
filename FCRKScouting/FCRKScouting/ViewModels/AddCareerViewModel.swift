//
//  AddCareerViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.07.2024.
//

import Foundation

protocol AddCareerViewModelProtocol {
    var wasRatioOfYearsWrong: (() -> Void)? { get set }
    var wereYearsRepeated: (() -> Void)? { get set }
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
    
    private let currentYear = Calendar.current.component(.year, from: Date())
    
    var wasRatioOfYearsWrong: (() -> Void)?
    var wereYearsRepeated: (() -> Void)?
    
    var years: [Int] {
        let years = Array(2000...currentYear)
        return years.reversed()
    }
    
    init(player: Player) {
        self.player = player
    }
    
    
    private func savePossibleCurrentLeague() {
        guard let careers = player.careers?.allObjects as? [Career] else {
            return
        }
        if let currentCareer = careers.first(where: {
            guard let year = $0.year else { return false }
            return Int(year.suffix(2)) == currentYear - 2000
        }) {
            guard let league = currentCareer.league else { return }
            StorageManager.shared.saveCurrentLeague(
                league,
                forPlayer: player.fullName ?? "")
        }
    }
    
    private func checkRepeatingOf(
        _ years: String,
        completion: @escaping () -> Void
    ) {
        guard let fullName = player.fullName else { return }
        StorageManager.shared.hasDuplicateCareer(
            period: String(years.suffix(2)),
            ofPlayer: fullName
        ) { [weak self] in
            guard let self else { return }
            $0 ? wereYearsRepeated?() : completion()
        }
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
        checkRepeatingOf(period) { [weak self] in
            guard let self else { return }
            let league = Constants.Texts.Leagues.allCases[league].rawValue
            StorageManager.shared.addCareer(
                forPlayer: player.fullName ?? "",
                forPeriod: period,
                league: league,
                coach: coach)
            savePossibleCurrentLeague()
            DispatchQueue.main.async {
                completion()
            }
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
