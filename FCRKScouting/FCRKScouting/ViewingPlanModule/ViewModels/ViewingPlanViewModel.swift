//
//  ViewingPlanViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.09.2024.
//

protocol AddTournamentViewControllerDelegate {
    var tournamentWasAdded: (() -> Void)? { get set }
}

protocol TournamentViewControllerDelegate: AnyObject {
    var tournamentWasDeleted: (() -> Void)? { get set }
}

protocol ViewingPlanViewModelProtocol: AddTournamentViewControllerDelegate,
                                       TournamentViewControllerDelegate,
                                       CurrentUserProtocol {
    var hasNoTournaments: Bool { get }
    func fetchTournaments(completion: @escaping () -> Void)
    func getNumberOfItems() -> Int
    func getTournamentCellViewModel(
        at index: Int
    ) -> TournamentCellViewModelProtocol
    func getTournament(at index: Int) -> Tournament
}

final class ViewingPlanViewModel: ViewingPlanViewModelProtocol {
    
    private var tournaments: [Tournament] = []
    
    var tournamentWasAdded: (() -> Void)?
    var tournamentWasDeleted: (() -> Void)?
    
    var hasNoTournaments: Bool {
        tournaments.isEmpty
    }
    
    func fetchTournaments(completion: @escaping () -> Void) {
        StorageManager.shared.fetchTournaments { [weak self] in
            guard let self else { return }
            tournaments = $0.sorted(by: {
                guard let firstStartDate = $0.startDate,
                      let secondStartDate = $1.startDate,
                      firstStartDate != secondStartDate else {
                    return false
                }
                return firstStartDate < secondStartDate
            })
            completion()
        }
    }
    
    func getNumberOfItems() -> Int {
        tournaments.count
    }
    
    func getTournamentCellViewModel(
        at index: Int
    ) -> TournamentCellViewModelProtocol {
        TournamentCellViewModel(tournament: tournaments[index])
    }
    
    func getTournament(at index: Int) -> Tournament {
        tournaments[index]
    }
}
