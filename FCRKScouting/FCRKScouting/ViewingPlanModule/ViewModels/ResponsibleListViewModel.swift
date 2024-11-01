//
//  ResponsibleListViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.10.2024.
//

protocol ResponsibleListViewModelProtocol {
    func getNumberOfRows() -> Int
    func getScoutShortName(forRow row: Int) -> String
    func addResponsibleOne(forRow row: Int)
}

final class ResponsibleListViewModel: ResponsibleListViewModelProtocol {
    
    private let tournament: Tournament
    
    private var scouts: [User] = []
    
    init(tournament: Tournament) {
        self.tournament = tournament
        fetchScouts()
    }
    
    private func fetchScouts() {
        StorageManager.shared.fetchEditingUsers { [weak self] in
            guard let self else { return }
            scouts = $0
        }
    }
    
    func getNumberOfRows() -> Int {
        scouts.count
    }
    
    func getScoutShortName(forRow row: Int) -> String {
        guard let fullName = scouts[row].fullName else { return "" }
        let components = fullName.components(separatedBy: " ")
        guard let abbreviatedName = fullName.first,
              let lastName = components.last else { return "" }
        return String(abbreviatedName) + ". " + lastName
    }
    
    func addResponsibleOne(forRow row: Int) {
        StorageManager.shared.addResponsibleOne(
            scouts[row],
            forTournament: tournament)
    }
}
