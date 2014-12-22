//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Robert Keifer on 12/21/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonPressed(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: context!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: context!)
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = datePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        var results: NSArray = context!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
