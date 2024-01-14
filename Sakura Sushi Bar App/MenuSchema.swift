//
//  MenuSchema.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 07/01/2024.
//

import RealmSwift

public class Menu: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var price: Int = 0
    @Persisted var desc: String = ""
    @Persisted var allergens: List<String> = List<String>()
    @Persisted var image: String = ""
}
