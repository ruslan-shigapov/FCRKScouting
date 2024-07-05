//
//  EditorViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 09.04.2024.
//

import UIKit

protocol TransferDetailsViewControllerDelegate {
    var prices: [String?] { get set }
    var contractDate: Date? { get set }
    var agentInfo: [String?] { get set }
}

protocol TestingDetailsViewControllerDelegate {
    var results: [String?] { get set }
    var scores: [String?] { get set }
    var summary: String? { get set }
}

protocol EditorViewModelProtocol: TextFieldValidationProtocol,     
                                  TransferDetailsViewControllerDelegate,
                                  TestingDetailsViewControllerDelegate {
    var wasPositionNotSelected: (() -> Void)? { get set }
    var wasImageChanged: (() -> Void)? { get set }
    var title: String { get }
    var selectedPhoto: UIImage? { get set }
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
    func getTestingDetails()
    func editPlayer(
        byFullName fullName: String,
        editedFullName: String?,
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
    
    var results: [String?] = []
    
    var scores: [String?] = []
    
    var summary: String?
            
    var wereRequiredTextFieldsEmpty: (() -> Void)?
    var wasFullNameIncorrect: (() -> Void)?
    var wasFullNameContainInvalidChars: (() -> Void)?
    var wasPositionNotSelected: (() -> Void)?
    var wasImageChanged: (() -> Void)?
    
    var title: String {
        guard player != nil else {
            return Constants.Text.ScreenTitles.addPlayer
        }
        return Constants.Text.ScreenTitles.editPlayer
    }
    
    var selectedPhoto: UIImage? {
        didSet {
            wasImageChanged?()
        }
    }
    
    init(player: Player?) {
        self.player = player
    }
    
    private func getPhotoData() -> Data? {
        if let selectedPhoto {
            return selectedPhoto.jpegData(compressionQuality: 1)
        }
        guard let currentData = player?.photo else { return nil }
        return currentData
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
        guard position != 0 else {
            wasPositionNotSelected?()
            return
        }
        let currentUser = UserManager.shared.getCurrentUser()
        StorageManager.shared.createPlayer(
            withFullName: fullName,
            photo: selectedPhoto?.jpegData(compressionQuality: 1),
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
            runningFor15MResult: results.count == 4 ? results[0] : nil,
            runningFor30MResult: results.count == 4 ? results[1] : nil,
            longJumpResult: results.count == 4 ? results[2] : nil,
            highJumpResult: results.count == 4 ? results[3] : nil,
            runningFor15MScore: scores.count == 4 ? scores[0] : nil,
            runningFor30MScore: scores.count == 4 ? scores[1] : nil,
            longJumpScore: scores.count == 4 ? scores[2] : nil,
            highJumpScore: scores.count == 4 ? scores[3] : nil,
            summary: summary,
            lastEditor: currentUser?.fullName ?? "",
            updatedDate: Date(),
            creator: currentUser?.fullName ?? "")
            completion()
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
    
    func getTestingDetails() {
        guard let player else { return }
        results = [
            player.runningFor15MResult,
            player.runningFor30MResult,
            player.longJumpResult,
            player.highJumpResult
        ]
        scores = [
            player.runningFor15MScore,
            player.runningFor30MScore,
            player.longJumpScore,
            player.highJumpScore
        ]
        summary = player.summary
    }
    
    func editPlayer(
        byFullName fullName: String,
        editedFullName: String?,
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
        guard position != 0 else {
            wasPositionNotSelected?()
            return
        }
        let currentUser = UserManager.shared.getCurrentUser()
        StorageManager.shared.updatePlayer(
            withFullName: fullName,
            editedFullName: editedFullName,
            photo: getPhotoData(),
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
            runningFor15MResult: results.count == 4 ? results[0] : nil,
            runningFor30MResult: results.count == 4 ? results[1] : nil,
            longJumpResult: results.count == 4 ? results[2] : nil,
            highJumpResult: results.count == 4 ? results[3] : nil,
            runningFor15MScore: scores.count == 4 ? scores[0] : nil,
            runningFor30MScore: scores.count == 4 ? scores[1] : nil,
            longJumpScore: scores.count == 4 ? scores[2] : nil,
            highJumpScore: scores.count == 4 ? scores[3] : nil,
            summary: summary,
            lastEditor: currentUser?.fullName ?? "",
            updatedDate: Date())
        completion()
    }
}
