//
//  SecondBasket+CoreDataProperties.swift
//  
//
//  Created by Josh Jarvis on 12/01/2024.
//
//

import Foundation
import CoreData


extension SecondBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SecondBasket> {
        return NSFetchRequest<SecondBasket>(entityName: "SecondBasket")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double

}
