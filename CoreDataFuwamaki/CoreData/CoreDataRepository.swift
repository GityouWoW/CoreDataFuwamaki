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
        let container = NSPersistentContainer(name: "SampleProject")
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

extension CoreDataRepository {
    static func isEnpty<T: NSManagedObject>(ob: T) -> Bool {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            let result = try context.fetch(request)
            if result.isEmpty {
                return true
            } else {
                return false
            }
        } catch {
            fatalError()
        }
    }
}

extension CoreDataRepository {
    
        static var checkLightWeightMigration: NSMappingModel {
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
//    static func c() {
//        print(checkLightWeightMigration)
//    }
}
