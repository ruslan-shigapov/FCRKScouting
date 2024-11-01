//
//  AddTournamentViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.09.2024.
//

import Foundation

protocol AddTournamentViewModelProtocol {
    var wereRequiredTextFieldsEmpty: (() -> Void)? { get set }
    var wasRatioOfDatesWrong: (() -> Void)? { get set }
    var wasRatioOfYearsWrong: (() -> Void)? { get set }
    var years: [Int] { get }
    func saveTournament(
        name: String,
        place: String,
        startDate: Date,
        endDate: Date,
        age: Int,
        toAge: Int?,
        completion: @escaping () -> Void
    )
    func checkRatioOf(year: Int, andYear toYear: Int, completion: () -> Void)
}

final class AddTournamentViewModel: AddTournamentViewModelProtocol {
    
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasRatioOfDatesWrong: (() -> Void)?
    var wasRatioOfYearsWrong: (() -> Void)?
    
    var years: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(2000...currentYear - 5)
    }
    
    private func format(age: Int, andToAge toAge: Int?) -> String {
        guard let toAge else { return "\(years[age])" }
        return "\(years[age])-\(years[toAge])"
    }
    
    func saveTournament(
        name: String,
        place: String,
        startDate: Date,
        endDate: Date,
        age: Int,
        toAge: Int?,
        completion: @escaping () -> Void
    ) {
        guard [name, place].allSatisfy({ !$0.isEmpty }) else {
            wereRequiredTextFieldsEmpty?()
            return
        }
        guard startDate <= endDate else {
            wasRatioOfDatesWrong?()
            return
        }
        StorageManager.shared.saveTournament(
            byName: name,
            place: place,
            startDate: startDate,
            endDate: endDate,
            age: format(age: age, andToAge: toAge))
        completion()
    }
    
    func checkRatioOf(year: Int, andYear toYear: Int, completion: () -> Void) {
        guard year < toYear else {
            wasRatioOfYearsWrong?()
            return
        }
        completion()
    }
}
