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
        let container = NSPersistentCloudKitContainer(name: "RubinScoutingApp")
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
    
    func saveUser(withName name: String, surname: String, access: Bool) {
        let user = User(context: viewContext)
        user.name = name
        user.surname = surname
        user.isEditAllowed = access
        saveContext()
    }
    
    func fetchUser(completion: (User?) -> Void) {
        let fetchRequest = User.fetchRequest()
        let user = try? viewContext.fetch(fetchRequest).first
        completion(user)
    }
        
    func deleteUser() {
        let fetchRequest = User.fetchRequest()
        do {
            let users = try viewContext.fetch(fetchRequest)
            users.forEach { viewContext.delete($0) }
            saveContext()
        } catch {
            viewContext.rollback()
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
            }
        }
    }
}
