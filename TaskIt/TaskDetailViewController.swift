//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/19/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var task:TaskModel!

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.taskTextField.text = self.task.task
        self.subtaskTextField.text = self.task.subtask
        self.taskDatePicker.date = self.task.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = taskDatePicker.date
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
