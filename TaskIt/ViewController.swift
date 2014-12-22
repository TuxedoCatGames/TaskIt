//
//  ViewController.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/19/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray:[[Task]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task1 = Task(task:"Study French", subtask:"Verbs", date:Date.from(year:2014, month:1, day:14), isCompleted:false)
        let task2 = Task(task:"Eat Dinner", subtask:"Burgers", date:Date.from(year:2014, month:6, day:9), isCompleted:false)
        let task3 = Task(task:"Gym", subtask:"Leg day", date:Date.from(year:2014, month:11, day:24), isCompleted:false)
        
        let taskArray = [task1, task2, task3]
        
        var completedArray = [Task(task: "Code", subtask: "Task Project", date: Date.from(year: 2014, month: 1, day: 1), isCompleted: true)]
        
        baseArray = [taskArray, completedArray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        baseArray[0] = baseArray[0].sorted {
            
            (taskOne:Task, taskTwo:Task) -> Bool in
            
                return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        self.tableView.reloadData()
    }

    // MARK: - table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskCell
        
        let task = baseArray[indexPath.section][indexPath.row]
        
        cell.taskLabel.text = task.task
        cell.subtaskLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(date: task.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var task = baseArray[indexPath.section][indexPath.row]
        task.isCompleted = !task.isCompleted

        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        baseArray[1 - indexPath.section].append(task)
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            
            let vc = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            vc.task = baseArray[indexPath!.section][indexPath!.row]
            vc.mainVC = self
            
        } else if segue.identifier == "showAddTask" {
            
            let vc = segue.destinationViewController as AddTaskViewController
            vc.mainVC = self
        }
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }
    
}

