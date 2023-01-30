//
//  Job+CoreDataClass.swift
//  CoreDataFuwamaki
//
//  Created by Yu on 2023/01/30.
//
//

import Foundation
import CoreData

@objc(Job)
public class Job: NSManagedObject {
    static func new(title: String) -> Job {
        let entity: Job = CoreDataRepository.entity()
        entity.jobId = UUID()
        entity.title = title
        return entity
    }

    func update(title: String) {
        self.title = title
    }

}
