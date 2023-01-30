//
//  Person+CoreDataProperties.swift
//  CoreDataFuwamaki
//
//  Created by Yu on 2023/01/30.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var personId: UUID?
//    @NSManaged public var jobId: UUID?

}

extension Person : Identifiable {

}
