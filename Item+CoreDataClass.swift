//
//  Item+CoreDataClass.swift
//  CoreDataFuwamaki
//
//  Created by Y on 2023/01/31.
//
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    static func new(title: String) -> Item {
        let entity: Item = CoreDataRepository.entity()
        entity.itemId = UUID()
        entity.title = title
        return entity
    }

    func update(title: String) {
        self.title = title
    }
    
    // 管理対象オブジェクトのコンテキストが保存操作を完了した後、管理対象オブジェクトのライフサイクルにコードを追加する機会を提供します。
    override public func didSave() {
        print("didSave"); debugPrint(self)
    }
}
