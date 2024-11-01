//
//  PlayerDTO.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.10.2024.
//

import Foundation

struct PlayerDTO: Encodable {
    
    let Full_name: String
    let Patronymic: String
    let Citizenship: String
    let Club: String
    let National_team: String
    let Birth_date: String
    let Position: String
    let Working_leg: String
    let Height: String
    let Weight: String
    let General_info: String
    let Technique: String
    let Tactics: String
    let Physical_qualities: String
    let Mentality: String
    let Cost: String
    let Salary: String
    let Contract_date: String
    let Agent_or_parent_name: String
    let Agent_or_parent_contacts: String
    let Testing_date: String
    let Running_for_15_meters_result: String
    let Running_for_15_meters_score: String
    let Running_for_30_meters_result: String
    let Running_for_30_meters_score: String
    let Long_jump_result: String
    let Long_jump_score: String
    let High_jump_result: String
    let High_jump_score: String
    let Test_conclusions: String
    let Current_league: String
    let Career_stages: [CareerStageDTO]
    let Creator_of_player_card: String
    let Last_editor_of_player_card: String
    let Last_editing_date: String
    
    static func getPlayerDTO(from player: Player) -> PlayerDTO {
        PlayerDTO(
            Full_name: player.fullName ?? "",
            Patronymic: player.patronymic ?? "",
            Citizenship: player.citizenship ?? "",
            Club: player.club ?? "",
            National_team: player.nationalTeam ?? "",
            Birth_date: player.birthDate?.format() ?? "",
            Position: player.position ?? "",
            Working_leg: player.foot ?? "",
            Height: player.height ?? "",
            Weight: player.weight ?? "",
            General_info: player.generalInfo ?? "",
            Technique: player.technique ?? "",
            Tactics: player.tactics ?? "",
            Physical_qualities: player.qualities ?? "",
            Mentality: player.mental ?? "",
            Cost: player.cost ?? "",
            Salary: player.salary ?? "",
            Contract_date: player.contractDate?.format() ?? "",
            Agent_or_parent_name: player.agentName ?? "",
            Agent_or_parent_contacts: player.agentContacts ?? "",
            Testing_date: player.testingDate?.format() ?? "",
            Running_for_15_meters_result: player.runningFor15MResult ?? "",
            Running_for_15_meters_score: player.runningFor15MScore ?? "",
            Running_for_30_meters_result: player.runningFor30MResult ?? "",
            Running_for_30_meters_score: player.runningFor30MScore ?? "",
            Long_jump_result: player.longJumpResult ?? "",
            Long_jump_score: player.longJumpScore ?? "",
            High_jump_result: player.highJumpResult ?? "",
            High_jump_score: player.highJumpScore ?? "",
            Test_conclusions: player.testingSummary ?? "",
            Current_league: player.currentLeague ?? "",
            Career_stages: CareerStageDTO.getCareerStagesDTO(
                from: player.careers),
            Creator_of_player_card: player.creator ?? "",
            Last_editor_of_player_card: player.lastEditor ?? "",
            Last_editing_date: player.updatedDate?.format() ?? ""
        )
    }
}

struct CareerStageDTO: Encodable {
    
    let Year_or_period: String
    let League: String
    let Coach: String
    
    static func getCareerStagesDTO(from careers: NSSet?) -> [CareerStageDTO] {
        guard let careers = careers as? Set<Career> else { return [] }
        return careers.map {
            CareerStageDTO(
                Year_or_period: $0.year ?? "",
                League: $0.league ?? "",
                Coach: $0.coachName ?? "")
        }
    }
}
