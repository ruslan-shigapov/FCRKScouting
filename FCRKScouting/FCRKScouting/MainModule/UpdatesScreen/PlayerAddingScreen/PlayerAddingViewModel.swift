//
//  PlayerAddingViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 09.04.2024.
//

protocol PlayerAddingViewModelProtocol {
    func savePlayer()
    func getNumberOfComponentsInPicker() -> Int
    func getNumberOfRowsInPicker() -> Int
    func getTitleFor(pickerRow: Int) -> String
}

final class PlayerAddingViewModel: PlayerAddingViewModelProtocol {
    
    func savePlayer() {
        
    }
    
    func getNumberOfComponentsInPicker() -> Int {
        1
    }
    
    func getNumberOfRowsInPicker() -> Int {
        Constants.Text.Positions.allCases.count
    }
    
    func getTitleFor(pickerRow: Int) -> String {
        Constants.Text.Positions.allCases[pickerRow].rawValue
    }
}
