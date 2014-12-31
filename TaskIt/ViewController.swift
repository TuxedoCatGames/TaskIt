//
//  ViewController.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/19/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: context, sectionNameKeyPath: "completed", cacheName: nil)
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
    }

    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskCell
        
        let task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        cell.taskLabel.text = task.task
        cell.subtaskLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(date: task.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if fetchedResultsController.sections?.count == 1 {
            
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTask: TaskModel = fetchedObjects[0] as TaskModel
            
            if testTask.completed == true {
                
                return "Completed"
                
            } else {
                
                return "To Do"
            }
        }
        
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        task.completed = !(task.completed == true)

        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            
            let vc = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            vc.task = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
        } else if segue.identifier == "showAddTask" {
            
            let vc = segue.destinationViewController as AddTaskViewController
        }
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    // MARK: - Core Data
    
    func taskFetchRequest() -> NSFetchRequest {
        
        let request = NSFetchRequest(entityName: "TaskModel")
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        let completedSort = NSSortDescriptor(key: "completed", ascending: true)
        
        request.sortDescriptors = [completedSort, dateSort]
        
        return request
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.reloadData()
    }
    
}

