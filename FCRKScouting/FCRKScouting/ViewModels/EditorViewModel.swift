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
    var title: String { get }
    func savePlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
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
    func getPlayer() -> Player?
    func getPickerRowBy(title: String?) -> Int?
    func getSegmentIndexBy(title: String?) -> Int?
    func getTransferDetails()
    func editPlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
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
    )
}

final class EditorViewModel: EditorViewModelProtocol {
        
    private let player: Player?

    var prices: [String?] = []
    
    var contractDate: Date?
    
    var agentInfo: [String?] = []
            
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    var wasPositionNotSelected: (() -> Void)?
    
    var title: String {
        guard player != nil else {
            return Constants.Text.ScreenTitles.addPlayer
        }
        return Constants.Text.ScreenTitles.editPlayer
    }
    
    init(player: Player?) {
        self.player = player
    }
        
    func savePlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
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
            StorageManager.shared.createPlayer(
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
                updatedDate: Date(),
                creator: currentUserFullName ?? "")
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
    
    func getPlayer() -> Player? {
        player
    }
    
    func getPickerRowBy(title: String?) -> Int? {
        let positions = Constants.Text.Positions.allCases
        for (index, position) in positions.enumerated() {
            if position.rawValue == title {
                return index
            }
        }
        return nil
    }
    
    func getSegmentIndexBy(title: String?) -> Int? {
        guard let title else { return nil }
        let footSegments = Constants.Text.SegmentedControlItems.footSegments
        return footSegments.firstIndex(of: title)
    }
    
    func getTransferDetails() {
        guard let player else { return }
        prices = [ player.cost, player.salary ]
        contractDate = player.contractDate
        agentInfo = [ player.agentName, player.agentContacts ]
    }
    
    func editPlayer(
        byFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
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
            StorageManager.shared.updatePlayer(
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
}
