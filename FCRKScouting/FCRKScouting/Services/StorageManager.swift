//
//  StorageManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import CoreData
import CloudKit

enum CloudError: Error {
    case recordNotFound
    case unknownError
}

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let identifier = """
    iCloud.RuslanShigapov.FCRKScouting.CloudKitContainer
    """
    
    private lazy var publicDatabase = CKContainer(
        identifier: identifier).publicCloudDatabase
    
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
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    private init() {}
    
    private func saveContext() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}

// MARK: - Access
extension StorageManager {
    
    private func findAccessRecordFromCloud(
        byKey key: String,
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        let predicate = NSPredicate(format: "key == %@", key)
        let query = CKQuery(recordType: "Access", predicate: predicate)
        publicDatabase.fetch(withQuery: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success((let matchResults, _)):
                    guard let matchResult = matchResults.first?.1 else {
                        completion(.failure(CloudError.recordNotFound))
                        return
                    }
                    completion(matchResult)
                case .failure(_):
                    completion(.failure(CloudError.unknownError))
                }
            }
        }
    }
    
    func fetchAccessFromCloud(
        byKey key: String,
        completion: @escaping (Result<Int64?, CloudError>) -> Void
    ) {
        findAccessRecordFromCloud(byKey: key) {
            switch $0 {
            case .success(let record):
                let accessValue = record.value(forKey: "accessValue") as? Int64
                completion(.success(accessValue))
            case .failure(let error):
                if let cloudError = error as? CloudError {
                    completion(.failure(cloudError))
                }
            }
        }
    }
}

// MARK: - User
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
    
    func addFavoritePlayer(_ player: Player) {
        let currentUser = UserManager.shared.getCurrentUser()
        currentUser?.addToFavorites(player)
        saveContext()
    }
    
    func deleteFavoritePlayer(_ player: Player) {
        let currentUser = UserManager.shared.getCurrentUser()
        currentUser?.removeFromFavorites(player)
        saveContext()
    }
}

// MARK: - Player
extension StorageManager {
    
    private func deletePlayerRecordFromCloud(
        byFullName fullName: String,
        completion: @escaping () -> Void
    ) {
        let predicate = NSPredicate(format: "CD_fullName == %@", fullName)
        let query = CKQuery(recordType: "CD_Player", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["CD_fullName"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.recordMatchedBlock = { [weak self] recordID, _ in
            guard let self else { return }
            publicDatabase.delete(withRecordID: recordID) { _, _ in }
            completion()
        }
        publicDatabase.add(queryOperation)
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
        player.photoData = photo
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
        player.careers = NSSet()
        player.lastEditor = lastEditor
        player.updatedDate = updatedDate
        player.creator = creator
        saveContext()
    }
    
    func fetchPlayers(completion: @escaping ([Player]) -> Void) {
        let fetchRequest = Player.fetchRequest()
        if let players = try? viewContext.fetch(fetchRequest) {
            completion(players)
        }
    }
    
    func hasDuplicatePlayer(byFullName fullName: String) -> Bool {
        let fetchRequest = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "fullName == %@", fullName)
        let players = try? viewContext.fetch(fetchRequest)
        guard let player = players?.first,
              let matchedFullName = player.fullName else { return false }
        return matchedFullName == fullName
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
    
    func fetchPlayersFromCloud(completion: @escaping () -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "CD_Player", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.queuePriority = .veryHigh
        var cloudPlayerFullNames: [String] = []
        queryOperation.recordMatchedBlock = { _, result in
            switch result {
            case .success(let record):
                if let fullName = record.value(
                    forKey: "CD_fullName") as? String {
                    cloudPlayerFullNames.append(fullName)
                }
            case .failure(_): break
            }
        }
        queryOperation.queryResultBlock = { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                let fetchRequest = Player.fetchRequest()
                let players = try? viewContext.fetch(fetchRequest)
                let playersToDelete = players?.filter {
                    !cloudPlayerFullNames.contains($0.fullName ?? "")
                }
                DispatchQueue.main.async {
                    playersToDelete?.forEach {
                        self.viewContext.delete($0)
                    }
                    self.saveContext()
                    completion()
                }
            case .failure(_): break
            }
        }
        publicDatabase.add(queryOperation)
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
            requiredPlayer.photoData = photo
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
    
    func addCareer(
        forPlayer fullName: String,
        forPeriod period: String,
        league: String,
        coach: String
    ) {
        fetchPlayers { [weak self] in
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            guard let self else { return }
            let career = Career(context: viewContext)
            career.year = period
            career.league = league
            career.coachName = coach
            requiredPlayer.addToCareers(career)
            saveContext()
        }
    }
    
    func deleteCareer(_ career: Career, forPlayer player: Player) {
        player.removeFromCareers(career)
        saveContext()
    }
    
    func deletePlayer(
        byFullName fullName: String,
        completion: @escaping () -> Void
    ) {
        fetchPlayers { [weak self] in
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            guard let self else { return }
            deletePlayerRecordFromCloud(byFullName: fullName) {
                DispatchQueue.main.async {
                    self.viewContext.delete(requiredPlayer)
                    self.saveContext()
                    completion()
                }
            }
        }
    }
}
