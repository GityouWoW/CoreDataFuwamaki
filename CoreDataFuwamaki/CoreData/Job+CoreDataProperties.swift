//
//  Job+CoreDataProperties.swift
//  CoreDataFuwamaki
//
//  Created by Yu on 2023/01/30.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var title: String
    @NSManaged public var jobId: UUID?
//    @NSManaged public var subTitle: String? // V2
}

extension Job : Identifiable {

}
