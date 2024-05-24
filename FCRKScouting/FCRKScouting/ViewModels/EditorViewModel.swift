//
//  EditorViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 09.04.2024.
//

import Foundation

protocol EditorViewModelProtocol: TextFieldValidationProtocol {
    var wasPositionNotSelected: (() -> Void)? { get set }
    func savePlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date,
        position: Int,
        foot: Int,
        generalInfo: String?,
        technique: String?,
        tactics: String?,
        qualities: String?,
        mental: String?,
        completion: () -> Void)
    func getNumberOfComponentsInPicker() -> Int
    func getNumberOfRowsInPicker() -> Int
    func getTitleFor(pickerRow: Int) -> String
}

final class EditorViewModel: EditorViewModelProtocol {

    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    var wasPositionNotSelected: (() -> Void)?
        
    func savePlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date,
        position: Int,
        foot: Int,
        generalInfo: String?,
        technique: String?,
        tactics: String?,
        qualities: String?,
        mental: String?,
        completion: () -> Void
    ) {
        if position == 0 {
            wasPositionNotSelected?()
            return
        } else {
            let currentUserFullName = UserManager.shared.user?.fullName
            StorageManager.shared.savePlayer(
                withFullName: fullName,
                patronymic: patronymic,
                citizenship: citizenship,
                club: club,
                nationalTeam: nationalTeam,
                birthDate: birthDate,
                position: Constants.Text.Positions.allCases[position].rawValue,
                foot: Constants.Text.SegmentedControlItems.footSegments[foot],
                generalInfo: generalInfo,
                technique: technique,
                tactics: tactics,
                qualities: qualities,
                mental: mental,
                lastEditor: currentUserFullName ?? "", 
                updatedDate: Date())
            completion()
        }
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
