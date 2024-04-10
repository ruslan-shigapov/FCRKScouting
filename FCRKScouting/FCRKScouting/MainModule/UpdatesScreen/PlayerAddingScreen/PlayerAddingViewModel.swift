//
//  PlayerAddingViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 09.04.2024.
//

enum Position: String, CaseIterable {
    case notSelected = "- не выбрано -"
    case goalkeeper = "Вратарь"
    case leftDefender = "Левый защитник"
    case rightDefender = "Правый защитник"
    case centerDefender = "Центральный защитник"
    case leftMidfield = "Левый полузащитник"
    case rightMidfield = "Правый полузащитник"
    case centerMidfield = "Центральный полузащитник"
    case forward = "Нападающий"
}

protocol PlayerAddingViewModelProtocol {
    func getNumberOfComponentsInPicker() -> Int
    func getNumberOfRowsInPicker() -> Int
    func getTitleFor(pickerRow: Int) -> String
}

final class PlayerAddingViewModel: PlayerAddingViewModelProtocol {
    
    func getNumberOfComponentsInPicker() -> Int {
        1
    }
    
    func getNumberOfRowsInPicker() -> Int {
        Position.allCases.count
    }
    
    func getTitleFor(pickerRow: Int) -> String {
        Position.allCases[pickerRow].rawValue
    }
}
