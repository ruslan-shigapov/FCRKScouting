//
//  PlayerExtraCardViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import Foundation

protocol PlayerExtraCardViewModelProtocol {
    var cost: String { get }
    var salary: String { get }
    var contractDate: String { get }
    var agentName: String { get }
    var contacts: String { get }
    var testingDate: String { get }
    var runningFor15MResult: String { get }
    var runningFor30MResult: String { get }
    var longJumpResult: String { get }
    var highJumpResult: String { get }
    var runningFor15MScore: String { get }
    var runningFor30MScore: String { get }
    var longJumpScore: String { get }
    var highJumpScore: String { get }
    var summary: String { get }
}

final class PlayerExtraCardViewModel: PlayerExtraCardViewModelProtocol {

    private let player: Player
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    var cost: String {
        guard let cost = player.cost, !cost.isEmpty else {
            return "0 \u{20BD}"
        }
        return "\(cost) \u{20BD}"
    }
    
    var salary: String {
        guard let salary = player.salary, !salary.isEmpty else {
            return "0 \u{20BD}"
        }
        return "\(salary) \u{20BD}"
    }
    
    var contractDate: String {
        guard let contractDate = player.contractDate else {
            return Constants.Text.notSpecified2
        }
        return dateFormatter.string(from: contractDate)
    }
    
    var agentName: String {
        guard let agentName = player.agentName, !agentName.isEmpty else {
            return ""
        }
        return agentName
    }
    
    var contacts: String {
        guard let contacts = player.agentContacts, !contacts.isEmpty else {
            return ""
        }
        return contacts
    }
    
    var testingDate: String {
        guard let testingDate = player.testingDate else {
            return Constants.Text.notSpecified1
        }
        return dateFormatter.string(from: testingDate)
    }
    
    var runningFor15MResult: String {
        guard let result = player.runningFor15MResult, !result.isEmpty else {
            return "0.00 сек"
        }
        return result + " сек"
    }
    
    var runningFor30MResult: String {
        guard let result = player.runningFor30MResult, !result.isEmpty else {
            return "0.00 сек"
        }
        return result + " сек"
    }
    
    var longJumpResult: String {
        guard let result = player.longJumpResult, !result.isEmpty else {
            return "0.00 м"
        }
        return result + " м"
    }
    
    var highJumpResult: String {
        guard let result = player.highJumpResult, !result.isEmpty else {
            return "0.00 м"
        }
        return result + " м"
    }
    
    var runningFor15MScore: String {
        guard let score = player.runningFor15MScore, !score.isEmpty else {
            return "0"
        }
        return score
    }
    
    var runningFor30MScore: String {
        guard let score = player.runningFor30MScore, !score.isEmpty else {
            return "0"
        }
        return score
    }
    
    var longJumpScore: String {
        guard let score = player.longJumpScore, !score.isEmpty else {
            return "0"
        }
        return score
    }
    
    var highJumpScore: String {
        guard let score = player.highJumpScore, !score.isEmpty else {
            return "0"
        }
        return score
    }
    
    var summary: String {
        player.testingSummary ?? ""
    }
    
    init(player: Player) {
        self.player = player
    }
}
