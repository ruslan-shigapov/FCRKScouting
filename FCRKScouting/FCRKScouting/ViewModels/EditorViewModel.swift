//
//  EditorViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 09.04.2024.
//

import Foundation

protocol TransferDetailsViewControllerDelegate {
    var prices: [String?] { get set }
    var contractDate: Date? { get set }
    var agentInfo: [String?] { get set }
}

protocol EditorViewModelProtocol: TextFieldValidationProtocol,     
                                  TransferDetailsViewControllerDelegate {
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
        height: String?,
        weight: String?,
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
        
    var prices: [String?] = []
    
    var contractDate: Date?
    
    var agentInfo: [String?] = []
            
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
        height: String?,
        weight: String?,
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
                height: height,
                weight: weight,
                generalInfo: generalInfo,
                technique: technique,
                tactics: tactics,
                qualities: qualities,
                mental: mental,
                cost: prices.count == 2 ? prices[0] : nil,
                salary: prices.count == 2 ? prices[1] : nil,
                contractDate: contractDate,
                agentName: agentInfo.count == 2 ? agentInfo[0] : nil,
                agentContacts: agentInfo.count == 2 ? agentInfo[1] : nil,
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
