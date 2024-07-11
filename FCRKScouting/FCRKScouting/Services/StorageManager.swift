//
//  StorageManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import CoreData
import CloudKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "FCRKScouting")
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.cloudKitContainerOptions?.databaseScope = .public
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Data loading error: \(error)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return context
    }

    private init() {}
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
            }
        }
    }
}

// MARK: - User CRUD
extension StorageManager {
    
    func saveUser(
        byAppleID appleID: String,
        fullName: String,
        isEditingAllowed: Bool,
        completion: @escaping (User?) -> Void
    ) {
        let user = User(context: viewContext)
        user.appleID = appleID
        user.fullName = fullName
        user.isEditingAllowed = isEditingAllowed
//        saveContext()
        completion(user)
    }
    
    func findUser(
        _ appleID: String,
        completion: @escaping (User?) -> Void
    ) {
        let fetchRequest = User.fetchRequest()
        let users = try? viewContext.fetch(fetchRequest)
        if let user = users?.first(where: { $0.appleID == appleID }) {
            completion(user)
            return
        }
        completion(nil)
    }
    
    func findUserFromCloud(
        byAppleID appleID: String,
        completion: @escaping (User?) -> Void
    ) {
        CloudManager.shared.findUserFromCloud(
            byAppleID: appleID
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let record):
                let user = User(context: viewContext)
                user.appleID = record.value(forKey: "CD_appleID") as? String
                user.fullName = record.value(forKey: "CD_fullName") as? String
                let accessValue = record.value(
                    forKey: "CD_isEditingAllowed") as? Int64
                user.isEditingAllowed = accessValue == 1 ? true : false
                DispatchQueue.main.async {
                    completion(user)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func renameUser(
        _ appleID: String,
        toFullName fullName: String,
        completion: @escaping (User?) -> Void
    ) {
        findUser(appleID) { [weak self] in
            guard let self, let foundUser = $0 else { return }
            foundUser.fullName = fullName
            saveContext()
            completion(foundUser)
        }
    }
}

// MARK: - Player CRUD
extension StorageManager {
    
    private func getImageData(from record: CKRecord) -> Data? {
        let imageAsset = record.value(forKey: "CD_photo") as? CKAsset
        guard let fileURL = imageAsset?.fileURL else { return nil }
        let data = try? Data(contentsOf: fileURL)
        return data
    }
    
    private func fetchPlayers(completion: @escaping ([Player]) -> Void) {
        let fetchRequest = Player.fetchRequest()
        if let players = try? viewContext.fetch(fetchRequest) {
            completion(players)
        }
    }
    
    func createPlayer(
        byFullName fullName: String,
        photo: Data?,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
        position: String,
        foot: String,
        height: String?,
        weight: String?,
        generalInfo: String?,
        technique: String?,
        tactics: String?,
        qualities: String?,
        mental: String?,
        cost: String?,
        salary: String?,
        contractDate: Date?,
        agentName: String?,
        agentContacts: String?,
        testingDate: Date?,
        runningFor15MResult: String?,
        runningFor30MResult: String?,
        longJumpResult: String?,
        highJumpResult: String?,
        runningFor15MScore: String?,
        runningFor30MScore: String?,
        longJumpScore: String?,
        highJumpScore: String?,
        summary: String?,
        lastEditor: String,
        updatedDate: Date,
        creator: String
    ) {
        let player = Player(context: viewContext)
        player.fullName = fullName
        player.photo = photo
        player.patronymic = patronymic
        player.citizenship = citizenship
        player.club = club
        player.nationalTeam = nationalTeam
        player.birthDate = birthDate
        player.position = position
        player.foot = foot
        player.height = height
        player.weight = weight
        player.generalInfo = generalInfo
        player.technique = technique
        player.tactics = tactics
        player.qualities = qualities
        player.mental = mental
        player.cost = cost
        player.salary = salary
        player.contractDate = contractDate
        player.agentName = agentName
        player.agentContacts = agentContacts
        player.testingDate = testingDate
        player.runningFor15MResult = runningFor15MResult
        player.runningFor30MResult = runningFor30MResult
        player.longJumpResult = longJumpResult
        player.highJumpResult = highJumpResult
        player.runningFor15MScore = runningFor15MScore
        player.runningFor30MScore = runningFor30MScore
        player.longJumpScore = longJumpScore
        player.highJumpScore = highJumpScore
        player.testingSummary = summary
        player.lastEditor = lastEditor
        player.updatedDate = updatedDate
        player.creator = creator
        saveContext()
//        CloudManager.shared.savePlayerToCloud(
//            player,
//            withImageData: photo
//        ) { [weak self] in
//            guard let self else { return }
//            player.recordName = $0
//            self.saveContext()
//        }
    }
    
    func fetchPlayersFromCloud(completion: @escaping (Player) -> Void) {
        CloudManager.shared.fetchPlayerFromCloud { [weak self] record in
            guard let self else { return }
            guard let entity = NSEntityDescription.entity(
                forEntityName: "Player",
                in: self.viewContext
            ) else {
                return
            }
            let player = Player(
                entity: entity,
                insertInto: self.viewContext)
            let fullName = record.value(
                forKey: "CD_fullName") as? String
            fetchPlayers {
                if $0.allSatisfy({ $0.fullName != fullName }) {
                    player.fullName = fullName
                    player.photo = self.getImageData(from: record)
                    player.patronymic = record.value(
                        forKey: "CD_patronymic") as? String
                    player.citizenship = record.value(
                        forKey: "CD_citizenship") as? String
                    player.club = record.value(
                        forKey: "CD_club") as? String
                    player.nationalTeam = record.value(
                        forKey: "CD_nationalTeam") as? String
                    player.birthDate = record.value(
                        forKey: "CD_birthDate") as? Date
                    player.position = record.value(
                        forKey: "CD_position") as? String
                    player.foot = record.value(
                        forKey: "CD_foot") as? String
                    player.height = record.value(
                        forKey: "CD_height") as? String
                    player.weight = record.value(
                        forKey: "CD_weight") as? String
                    player.generalInfo = record.value(
                        forKey: "CD_generalInfo") as? String
                    player.technique = record.value(
                        forKey: "CD_technique") as? String
                    player.tactics = record.value(
                        forKey: "CD_tactics") as? String
                    player.qualities = record.value(
                        forKey: "CD_qualities") as? String
                    player.mental = record.value(
                        forKey: "CD_mental") as? String
                    player.cost = record.value(
                        forKey: "CD_cost") as? String
                    player.salary = record.value(
                        forKey: "CD_salary") as? String
                    player.contractDate = record.value(
                        forKey: "CD_contractDate") as? Date
                    player.agentName = record.value(
                        forKey: "CD_agentName") as? String
                    player.agentContacts = record.value(
                        forKey: "CD_agentContacts") as? String
                    player.testingDate = record.value(
                        forKey: "CD_testingDate") as? Date
                    player.runningFor15MResult = record.value(
                        forKey: "CD_runningFor15MResult") as? String
                    player.runningFor30MResult = record.value(
                        forKey: "CD_runningFor30MResult") as? String
                    player.longJumpResult = record.value(
                        forKey: "CD_longJumpResult") as? String
                    player.highJumpResult = record.value(
                        forKey: "CD_highJumpResult") as? String
                    player.runningFor15MScore = record.value(
                        forKey: "CD_runningFor15MScore") as? String
                    player.runningFor30MScore = record.value(
                        forKey: "CD_runningFor30MScore") as? String
                    player.longJumpScore = record.value(
                        forKey: "CD_longJumpScore") as? String
                    player.highJumpScore = record.value(
                        forKey: "CD_highJumpScore") as? String
                    player.testingSummary = record.value(
                        forKey: "CD_summary") as? String
                    player.lastEditor = record.value(
                        forKey: "CD_lastEditor") as? String
                    player.updatedDate = record.value(
                        forKey: "CD_updatedDate") as? Date
                    player.creator = record.value(
                        forKey: "CD_creator") as? String
                    self.saveContext()
                    DispatchQueue.main.async {
                        completion(player)
                    }
                }
            }
        }
    }

    
    func fetchRelatedPlayers(
        forUser userFullName: String,
        completion: @escaping ([Player]) -> Void
    ) {
        fetchPlayers { players in
            let relatedPlayers = players.filter { $0.creator == userFullName }
            completion(relatedPlayers)
        }
    }
    
    func findPlayers(
        byText text: String,
        completion: @escaping ([Player]) -> Void
    ) {
        let fetchRequest = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "fullName CONTAINS[cd] %@",
            text)
        if let players = try? viewContext.fetch(fetchRequest) {
            completion(players)
        }
    }
    
    func updatePlayer(
        byFullName fullName: String,
        editedFullName: String?,
        photo: Data?,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date?,
        position: String,
        foot: String,
        height: String?,
        weight: String?,
        generalInfo: String?,
        technique: String?,
        tactics: String?,
        qualities: String?,
        mental: String?,
        cost: String?,
        salary: String?,
        contractDate: Date?,
        agentName: String?,
        agentContacts: String?,
        testingDate: Date?,
        runningFor15MResult: String?,
        runningFor30MResult: String?,
        longJumpResult: String?,
        highJumpResult: String?,
        runningFor15MScore: String?,
        runningFor30MScore: String?,
        longJumpScore: String?,
        highJumpScore: String?,
        summary: String?,
        lastEditor: String,
        updatedDate: Date
    ) {
        fetchPlayers { [weak self] in
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            guard let self else { return }
            requiredPlayer.fullName = editedFullName
            requiredPlayer.photo = photo
            requiredPlayer.patronymic = patronymic
            requiredPlayer.citizenship = citizenship
            requiredPlayer.club = club
            requiredPlayer.nationalTeam = nationalTeam
            requiredPlayer.birthDate = birthDate
            requiredPlayer.position = position
            requiredPlayer.foot = foot
            requiredPlayer.height = height
            requiredPlayer.weight = weight
            requiredPlayer.generalInfo = generalInfo
            requiredPlayer.technique = technique
            requiredPlayer.tactics = tactics
            requiredPlayer.qualities = qualities
            requiredPlayer.mental = mental
            requiredPlayer.cost = cost
            requiredPlayer.salary = salary
            requiredPlayer.contractDate = contractDate
            requiredPlayer.agentName = agentName
            requiredPlayer.agentContacts = agentContacts
            requiredPlayer.testingDate = testingDate
            requiredPlayer.runningFor15MResult = runningFor15MResult
            requiredPlayer.runningFor30MResult = runningFor30MResult
            requiredPlayer.longJumpResult = longJumpResult
            requiredPlayer.highJumpResult = highJumpResult
            requiredPlayer.runningFor15MScore = runningFor15MScore
            requiredPlayer.runningFor30MScore = runningFor30MScore
            requiredPlayer.longJumpScore = longJumpScore
            requiredPlayer.highJumpScore = highJumpScore
            requiredPlayer.testingSummary = summary
            requiredPlayer.lastEditor = lastEditor
            requiredPlayer.updatedDate = updatedDate
            saveContext()
        }
    }
    
    func deletePlayer(byFullName fullName: String) {
        fetchPlayers { [weak self] in
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            guard let self else { return }
            viewContext.delete(requiredPlayer)
            saveContext()
        }
    }
}
