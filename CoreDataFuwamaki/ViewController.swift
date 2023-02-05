//
//  ViewController.swift
//  CoreDataFuwamaki
//
//  Created by Yu on 2023/01/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// Save
    @IBAction func saveTaped(_ sender: Any) {
        person()
        job()
        item() // V2
        CoreDataRepository.save()

        func person() {
            let personItems: [Person] = CoreDataRepository.array()
            if personItems.isEmpty {
                // 追加
                CoreDataRepository.add(Person.newEntity(personId: UUID(), name: "NewNameV1", age: 1111))
            } else {
                // 更新
                if let firstItem = personItems.first {
                    firstItem.update(name: "Update NameV1", age: firstItem.age + 1)
                }
            }
        }
        
        func job() {
            let jobItems: [Job] = CoreDataRepository.array()
            if jobItems.isEmpty {
                // 追加
                CoreDataRepository.add(Job.new(title: "New Job" + "\n" + Date().description, subTitle: "NewSubTitle V2"))
            } else {
                // 更新
                if let firstItem = jobItems.first {
                    firstItem.update(title: "Update Job" + "\n" + Date().description, subTitle: "UpdateSubTitle V22")
                }
            }
        }
        
        func item() {
            let items: [Item] = CoreDataRepository.array()
            CoreDataRepository.add(Item.new(title: "New Item V2" + "\n" + Date().description))
            if let firstItem = items.first {
                firstItem.update(title: "Update Item V2" + "\n" + Date().description)
            }
        }
    }

    /// Delete
    @IBAction func deleteTaped(_ sender: Any) {
        person()
        job()
        item()
        CoreDataRepository.save()

        func person() {
            let personItems: [Person] = CoreDataRepository.array()
            for personItem in personItems {
                CoreDataRepository.delete(personItem)
            }
            if personItems.isEmpty {
                outputLabel.text = "Enpty"
            }
        }
        
        func job() {
            let jobItems: [Job] = CoreDataRepository.array()
            for item in jobItems {
                CoreDataRepository.delete(item)
            }
            if jobItems.isEmpty {
                outputLabel.text = "Enpty"
            }
        }
        
        func item() {
            let items: [Item] = CoreDataRepository.array()
            for item in items {
                CoreDataRepository.delete(item)
            }
            if items.isEmpty {
                outputLabel.text = "Enpty"
            }
        }
    }
    
    /// Fetch
    @IBAction func fetchTaped(_ sender: Any) {
        var s = ""
        s = person()
        s += job()
        s += item() // V2
        
        outputLabel.text = s
        
        /// person
        func person() -> String {
            let personItems: [Person] = CoreDataRepository.array()
            if personItems.isEmpty {
                return "Person is Empty"
            } else {
                guard let firstPerson = personItems.first else { return "Person is Empty" }
                debugPrint(firstPerson)
                return "Name" + (firstPerson.name ?? "name") + "Age" + String(firstPerson.age)
            }
        }
        
        /// Job
        func job() -> String {
            let jobItems: [Job] = CoreDataRepository.array()
            if jobItems.isEmpty {
                return "Job is Enpty"
            }
            guard let firstJob = jobItems.first else { return "Job is Enpty" }
            debugPrint(firstJob)
            return firstJob.title ?? "title"
        }
        
        /// Item
        func item() -> String {
            let items: [Item] = CoreDataRepository.array()
            if items.isEmpty {
                outputLabel.text = outputLabel.text ?? "" + "\n" + "Item is Enpty"
                return "Item is Enpty"
            } else {
                guard let firstItem = items.first else { return "Item is Enpty"}
                outputLabel.text = outputLabel.text ?? "" + firstItem.title!
                debugPrint(firstItem)
                return firstItem.title ?? "xxx"
            }
        }
    }
}

