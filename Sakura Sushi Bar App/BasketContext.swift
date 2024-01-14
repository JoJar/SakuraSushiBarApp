//
//  BasketContext.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 09/01/2024.
//

import CoreData
import UIKit

struct MenuType2: Codable {
    var name: String
    var price: Double
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error saving context: \(error), \(error.userInfo)")
        }
    }

    public func addItemToBasket(name: String, price: Double) {
        let context = viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "SecondBasket", in: context) else {
            print("Failed to get entity description")
            return
        }

        if let newObject = NSManagedObject(entity: entity, insertInto: context) as? SecondBasket {
            newObject.name = name
            newObject.price = price
            saveContext()
        } else {
            print("Failed to create NSManagedObject")
        }
    }

    public func fetchBasket(byName name: String) -> [SecondBasket] {
        let context = viewContext
        let fetchRequest: NSFetchRequest<SecondBasket> = SecondBasket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let results = try context.fetch(fetchRequest)
            let firstResult = results.compactMap { $0 }
            return firstResult
        } catch let error as NSError {
            print("Error fetching menu item: \(error), \(error.userInfo)")
            return []
        }
    }
    
    public func fetchAllBaskets() -> [SecondBasket] {
        let context = viewContext
        let fetchRequest: NSFetchRequest<SecondBasket> = SecondBasket.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            let allBaskets = results.compactMap { $0 }
            return allBaskets
        } catch let error as NSError {
            print("Error fetching menu items: \(error), \(error.userInfo)")
            return []
        }
    }
    
    
    public func resetDataOnLaunch() {
        let storeURL = persistentContainer.persistentStoreDescriptions.first?.url

        do {
            // Delete the existing persistent store
            try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: storeURL!, ofType: NSSQLiteStoreType, options: nil)

            // Recreate the persistent store
            try persistentContainer.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)

            print("Core Data store reset successfully.")
        } 
        catch {
            print("Error resetting Core Data store: \(error)")
        }
    }
}
