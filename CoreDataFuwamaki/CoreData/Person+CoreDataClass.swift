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
  
    static func newEntity(personId: UUID, name: String, age: Int16) -> Person {
        let entity: Person = CoreDataRepository.entity()
        print("Person Entity = ", entity)
        entity.name = name
        entity.age = age
        return entity
    }
    
    func update(name: String, age: Int16) {
        self.name = name
        self.age = age
    }
    
    
    override public func awakeFromInsert() {
        personId = UUID()
        debugPrint(self)
    }
    
    // 保存する前に、管理対象オブジェクトのライフサイクルにコードを追加する機会を提供します。
//    override public func willSave() {
//        print("willSave"); debugPrint(self)
//    }
    // 管理対象オブジェクトのコンテキストが保存操作を完了した後、管理対象オブジェクトのライフサイクルにコードを追加する機会を提供します。
    override public func didSave() {
        print("didSave"); debugPrint(self)
    }
}
