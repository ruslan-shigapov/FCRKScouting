//
//  StorageManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "FCRKScouting")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Data loading error: \(error)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
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
        saveContext()
        completion(user)
    }
    
    func findUser(_ appleID: String, completion: @escaping (User?) -> Void) {
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
            guard let self else { return }
            if let foundUser = $0 {
                foundUser.fullName = fullName
                saveContext()
                completion(foundUser)
            }
        }
    }
        
    func deleteUser(_ appleID: String, completion: @escaping () -> Void) {
        findUser(appleID) { [weak self] in
            guard let self else { return }
            if let foundUser = $0 {
                viewContext.delete(foundUser)
                saveContext()
                completion()
            }
        }
    }
}

// MARK: - Player CRUD
extension StorageManager {
    
    func createPlayer(
        withFullName fullName: String,
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
    
    func updatePlayer(
        withFullName fullName: String,
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
