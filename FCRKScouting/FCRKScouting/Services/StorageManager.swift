//
//  StorageManager.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 15.03.2024.
//

import CoreData

final class StorageManager {
    
    // MARK: Properties
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
    
    // MARK: Private Methods
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
            }
        }
    }
    
    // MARK: User's CRUD
    func saveUser(withFullName fullName: String, andAccess access: Bool) {
        let user = User(context: viewContext)
        user.fullName = fullName
        user.isEditAllowed = access
        saveContext()
    }
    
    func fetchUser(completion: (User?) -> Void) {
        let fetchRequest = User.fetchRequest()
        let user = try? viewContext.fetch(fetchRequest).first
        completion(user)
    }
        
    func deleteUsers() {
        let fetchRequest = User.fetchRequest()
        do {
            let users = try viewContext.fetch(fetchRequest)
            users.forEach { viewContext.delete($0) }
            saveContext()
        } catch {
            viewContext.rollback()
        }
    }
    
    // MARK: Player's CRUD
    func savePlayer(
        withFullName fullName: String,
        citizenship: String,
        club: String,
        birthDate: Date,
        position: String,
        foot: String,
        generalInfo: String?,
        technique: String?,
        tactics: String?,
        qualities: String?,
        mental: String?,
        lastEditor: String,
        updatedDate: Date
    ) {
        let player = Player(context: viewContext)
        player.fullName = fullName
        player.citizenship = citizenship
        player.club = club
        player.birthDate = birthDate
        player.position = position
        player.foot = foot
        player.generalInfo = generalInfo
        player.technique = technique
        player.tactics = tactics
        player.qualities = qualities
        player.mental = mental
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
    
    func deletePlayers() {
        let fetchRequest = Player.fetchRequest()
        do {
            let players = try viewContext.fetch(fetchRequest)
            players.forEach { viewContext.delete($0) }
            saveContext()
        } catch {
            viewContext.rollback()
        }
    }
}
