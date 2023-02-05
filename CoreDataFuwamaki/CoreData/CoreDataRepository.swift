//
//  CoreDataRepository.swift
//  Swift:CoreDataを使ってみる（入門UIKit）
//
//  Created by Yu on 2023/01/30.
//
// https://www.fuwamaki.com/article/325

import CoreData

class CoreDataRepository {

    init() {}

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataFuwamaki")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private static var context: NSManagedObjectContext {
        return CoreDataRepository.persistentContainer.viewContext
    }
}

// MARK: for Create
extension CoreDataRepository {
    static func entity<T: NSManagedObject>() -> T {
//        let newbook = NSEntityDescription.insertNewObject(forEntityName: <#T##String#>, into: <#T##NSManagedObjectContext#>)
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context)!
        return T(entity: entityDescription, insertInto: nil)
    }
}

// MARK: CRUD
extension CoreDataRepository {
    static func array<T: NSManagedObject>() -> [T] {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }

    static func add(_ object: NSManagedObject) {
        context.insert(object)
    }

    static func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}

// MARK: context CRUD
extension CoreDataRepository {
    static func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
        }
    }

    static func rollback() {
        guard context.hasChanges else { return }
        context.rollback()
    }
}

// Migration
extension CoreDataRepository {
    
    // ソースから宛先モデルにデータを移行するための新しく作成されたマッピングモデル。マッピングモデルを作成できない場合は、nilを返します。
    static var mappingModel: NSMappingModel {
        let subdirectory = "CoreDataFuwamaki.momd"
        guard let sourceModelURL = Bundle.main.url(forResource: "CoreDataFuwamaki", withExtension: "mom", subdirectory: subdirectory) else { print("Error 01"); fatalError() }
        guard let destinationModelURL = Bundle.main.url(forResource: "CoreDataFuwamaki 2", withExtension: "mom", subdirectory: subdirectory) else { print("Error 01"); fatalError() }
        
        let sourceModel = NSManagedObjectModel(contentsOf: sourceModelURL)!
        let destinationModel = NSManagedObjectModel(contentsOf: destinationModelURL)!
        
        do {
            return try NSMappingModel.inferredMappingModel(forSourceModel: sourceModel, destinationModel: destinationModel)
        } catch {
            fatalError("migrationCheck error \(error)")
        }
    }
    
    // 軽量マイグレーション設定をTrueにする
    static func mirgeAutomaticallyTrue(auto: Bool) {
//        let container = NSPersistentContainer(name: "CoreDataFuwamaki")
        /*移行に必要なサポートを追加*/
        let description = NSPersistentStoreDescription()
        
        // 現在の設定をチェック
        print("mirgeAutomaticallyTrue", description.shouldMigrateStoreAutomatically, description.shouldInferMappingModelAutomatically)
        // 現在の設定変更
        description.shouldMigrateStoreAutomatically = auto
        description.shouldInferMappingModelAutomatically = auto
        //        container.persistentStoreDescriptions = [description]
    }
    
    // 自動マッピングの取得
//    static func getLightWeightMigrationMapping() {
//        var modelBundle: Bundle {
//            print(Bundle.main)
//            return Bundle.main
//        }
//
//        var modelDirectoryName: String {
//            return "CoreDataFuwamaki.momd"
//        }
//
//        if let mappingModel = inferredMappingModel(migrationModel) {
//            print(mappingModel)
//        } else {
//            print("Error")
//        }
//    }
    
    ///
    var checkLightWeightMigration: NSMappingModel {
        let subdirectory = "PadelLessonLog.momd"
        let sourceModel = NSManagedObjectModel(contentsOf: Bundle.main.url(forResource: "CoreDataFuwamaki", withExtension: "mom", subdirectory: subdirectory)!)!
        let destinationModel = NSManagedObjectModel(contentsOf: Bundle.main.url(forResource: "CoreDataFuwamaki 2", withExtension: "mom", subdirectory: subdirectory)!)!
        do {
            return try NSMappingModel.inferredMappingModel(forSourceModel: sourceModel, destinationModel: destinationModel)
        } catch {
            fatalError("migrationCheck error \(error)")
        }
    }
}
