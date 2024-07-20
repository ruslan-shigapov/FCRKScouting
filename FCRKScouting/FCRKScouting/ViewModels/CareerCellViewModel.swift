//
//  CareerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

protocol CareerCellViewModelProtocol {
    var year: String { get }
    var league: String { get }
    var coachName: String { get }
}

final class CareerCellViewModel: CareerCellViewModelProtocol {
    
    private let career: Career
    
    var year: String {
        career.year ?? ""
    }
    
    var league: String {
        if let coachName = career.coachName, !coachName.isEmpty {
            return "\(career.league ?? ""). Тренер:"
        }
        return career.league ?? ""
    }
    
    var coachName: String {
        career.coachName ?? ""
    }
    
    init(career: Career) {
        self.career = career
    }
}
