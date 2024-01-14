//
//  MenuController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 07/01/2024.
//

import Foundation
import RealmSwift
import Realm

public struct MenuType: Codable {
    let name: String
    let price: Double
    let desc: String
    let allergens: List<String>
    let image: String
}

public func findMenuItems(completion: @escaping ([MenuType]) -> Void) {
    let app = App(id: "")
    
    app.login(credentials: Credentials.anonymous) { (result) in

        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
            case .success(let user):
                print("Login as \(user) succeeded!")
                
                // mongodb-atlas is the cluster service name
                let mongoClient = user.mongoClient("menuCluster")
                
                // Select the database
                let database = mongoClient.database(named: "menu")
                
                // Select the collection
                let collection = database.collection(withName: "menu")
                
                // I probs want to add a filter for the menu but not right now.
                let queryFilter: Document = [:]
                collection.find(filter: queryFilter) { result in
                    switch result {
                    case .failure(let error):
                        print("Call to MongoDB failed: \(error.localizedDescription)")
                        return
                    case .success(let bsonDocumentArray):
                        let menuItems: [MenuType] = bsonDocumentArray.compactMap { bsonDocument in
                            // Convert BSON document to CoffeeDrink
                            let allergensArray = (bsonDocument["allergens"] as? RealmSwift.AnyBSON)?.arrayValue?.compactMap { $0?.stringValue }

                            guard
                                let name = (bsonDocument["name"] as? RealmSwift.AnyBSON)?.stringValue,
                                let price = (bsonDocument["price"] as? RealmSwift.AnyBSON)?.doubleValue,
                                let desc = (bsonDocument["description"] as? RealmSwift.AnyBSON)?.stringValue,
                                let allergensArray = allergensArray,
                                let image = (bsonDocument["image"] as? RealmSwift.AnyBSON)?.stringValue
                            else {
                                return MenuType(name: "", price: 0, desc: "", allergens: List<String>(), image: "")
                            }
                            let allergens = List<String>()
                                allergens.append(objectsIn: allergensArray)
                            return MenuType(name: name, price: price, desc: desc, allergens: allergens, image: image)
                        }
                        completion(menuItems)
                    }
                }
            }
        }
    }
}
