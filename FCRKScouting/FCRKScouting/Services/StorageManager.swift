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
    
    func saveUserWith(
        fullName: String,
        post: String,
        isEditingAllowed: Bool,
        completion: () -> Void
    ) {
        let user = User(context: viewContext)
        user.fullName = fullName
        user.post = post
        user.isEditingAllowed = isEditingAllowed
        saveContext()
        completion()
    }
    
    func fetchUser(completion: (User?) -> Void) {
        let fetchRequest = User.fetchRequest()
        let user = try? viewContext.fetch(fetchRequest).first
        // TODO: find the user by its name ???
        completion(user)
    }
    
    func updateUser(fullName: String, post: String, completion: () -> Void) {
        fetchUser {
            $0?.fullName = fullName
            $0?.post = post
        }
        saveContext()
        completion()
    }
        
    func deleteUserBy(_ fullName: String) {
        let fetchRequest = User.fetchRequest()
        let users = try? viewContext.fetch(fetchRequest)
        guard let user = users?.first(where: { $0.fullName == fullName }) else {
            return
        }
        viewContext.delete(user)
        saveContext()
    }
}

// MARK: - Player CRUD
extension StorageManager {
    
    func createPlayer(
        withFullName fullName: String,
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
    
    func readPlayers(completion: ([Player]) -> Void) {
        let fetchRequest = Player.fetchRequest()
        if let players = try? viewContext.fetch(fetchRequest) {
            completion(players)
        }
    }
    
    func updatePlayer(
        withFullName fullName: String,
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
        readPlayers {
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            requiredPlayer.fullName = fullName
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
    
    func deletePlayerBy(_ fullName: String) {
        readPlayers {
            guard let requiredPlayer = $0.first(where: { player in
                player.fullName == fullName
            }) else {
                return
            }
            viewContext.delete(requiredPlayer)
            saveContext()
        }
    }
    
    func deletePlayers() {
        readPlayers {
            $0.forEach { viewContext.delete($0) }
            saveContext()
        }
    }
}
