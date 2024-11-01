//
//  PopoverViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.08.2024.
//

protocol PopoverViewModelProtocol {
    func getNumberOfRows() -> Int
    func getLeagueName(forRow row: Int) -> String
}

final class PopoverViewModel: PopoverViewModelProtocol {
    
    func getNumberOfRows() -> Int {
        Constants.Texts.Leagues.allCases.count
    }
    
    func getLeagueName(forRow row: Int) -> String {
        Constants.Texts.Leagues.allCases[row].rawValue
    }
}
