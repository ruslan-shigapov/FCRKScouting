//
//  CareerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

protocol CareerCellViewModelProtocol: AnyObject {
    var year: String { get }
    var careerInfo: String { get }
}

final class CareerCellViewModel: CareerCellViewModelProtocol {
    
    private let career: Career
    
    var year: String {
        career.year ?? ""
    }
    
    var careerInfo: String {
        let notSelectedLeague = Constants.Texts.Leagues.notSelected.rawValue
        guard career.league != notSelectedLeague else {
            return career.coachName ?? ""
        }
        if let coachName = career.coachName, !coachName.isEmpty {
            return "\(career.league ?? ""). Тренер: \(coachName)"
        }
        return career.league ?? ""
    }
    
    init(career: Career) {
        self.career = career
    }
}
