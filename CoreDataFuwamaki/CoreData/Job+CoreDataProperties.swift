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
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        jobId = UUID()
    }
    
    public override func didSave() {
        debugPrint(self)
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var jobId: UUID
    @NSManaged public var title: String

}

extension Job : Identifiable {

}
