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
    static func new(title: String, subTitle: String) -> Job {
        let entity: Job = CoreDataRepository.entity()
        entity.jobId = UUID()
        entity.title = title
//        entity.subTitle = subTitle // V2
        return entity
    }

    func update(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle // V2
    }
    
    override public func didSave() {
        print("didSave"); debugPrint(self)
    }
}
