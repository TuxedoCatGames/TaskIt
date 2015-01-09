//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Robert Keifer on 12/21/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    
    func addTask(message: String)
    func addTaskCancelled(message: String)
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCancelled("Task Not Added")
    }

    @IBAction func addTaskButtonPressed(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: context!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: context!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey("capitalize") {
            task.task = taskTextField.text.capitalizedString
        } else {
            task.task = taskTextField.text
        }
        
        task.completed = NSUserDefaults.standardUserDefaults().boolForKey("complete")
        
        task.subtask = subtaskTextField.text
        task.date = datePicker.date
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        var results: NSArray = context!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task Added")
    }
}
