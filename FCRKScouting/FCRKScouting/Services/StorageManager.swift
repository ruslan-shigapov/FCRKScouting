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
    
    func savePlayer(
        withFullName fullName: String,
        patronymic: String?,
        citizenship: String,
        club: String,
        nationalTeam: String?,
        birthDate: Date,
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
        saveContext()
    }
    
    func fetchPlayers(completion: ([Player]) -> Void) {
        let fetchRequest = Player.fetchRequest()
        if let players = try? viewContext.fetch(fetchRequest) {
            completion(players)
        }
    }
    
    // TODO: добавить изменение and delete only one player
    
    func deletePlayers() {
        let fetchRequest = Player.fetchRequest()
        let players = try? viewContext.fetch(fetchRequest)
        players?.forEach { viewContext.delete($0) }
        saveContext()
    }
}
