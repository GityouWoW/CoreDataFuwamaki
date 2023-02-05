//
//  Item+CoreDataProperties.swift
//  CoreDataFuwamaki
//
//  Created by Y on 2023/01/31.
//
//
//
import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemId: UUID?
    @NSManaged public var title: String?

}

extension Item : Identifiable {

}
