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

    // Save
    @IBAction func saveTaped(_ sender: Any) {
        let jobItems: [Job] = CoreDataRepository.array()
        if jobItems.isEmpty {
            // 追加
            CoreDataRepository.add(Job.new(title: "New"))
        } else {
            // 更新
            if let firstItem = jobItems.first {
                firstItem.update(title: "Update")
                CoreDataRepository.save()
            }
        }
    }

    @IBAction func deleteTaped(_ sender: Any) {
        let jobItems: [Job] = CoreDataRepository.array()
        for jobItem in jobItems {
            CoreDataRepository.delete(jobItem)
        }
    }
    
    @IBAction func fetchTaped(_ sender: Any) {
        // Fetch
        let jobItems: [Job] = CoreDataRepository.array()
        guard let firstJob = jobItems.first else { return }
        outputLabel.text = firstJob.title! + firstJob.jobId!.uuidString
        debugPrint(firstJob)
    }
}

