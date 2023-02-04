//
//  Person+CoreDataClass.swift
//  CoreDataFuwamaki
//
//  Created by Yu on 2023/01/30.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    static func new(name: String, age: Int16) -> Person {
        let entity: Person = CoreDataRepository.entity()
        entity.name = name
        entity.age = age
//        entity.jobId = jobId
        return entity
    }

    func update(name: String, age: Int16) {
        self.name = name
        self.age += age
    }

}
