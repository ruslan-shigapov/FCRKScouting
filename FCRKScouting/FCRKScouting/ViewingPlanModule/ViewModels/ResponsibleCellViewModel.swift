//
//  ResponsibleCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.10.2024.
//

protocol ResponsibleCellViewModelProtocol {
    var scoutName: String { get }
    func getResponsibleOne() -> User
}

final class ResponsibleCellViewModel: ResponsibleCellViewModelProtocol {
    
    private let scout: User
    
    init(scout: User) {
        self.scout = scout
    }
    
    var scoutName: String {
        guard let fullName = scout.fullName else { return "" }
        let components = fullName.components(separatedBy: " ")
        guard let abbreviatedName = fullName.first,
              let lastName = components.last else { return "" }
        return String(abbreviatedName) + ". " + lastName
    }
    
    func getResponsibleOne() -> User {
        scout
    }
}
