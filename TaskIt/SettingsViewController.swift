//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/31/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewToDoTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        capitalizeTableView.delegate = self
        capitalizeTableView.dataSource = self
        capitalizeTableView.scrollEnabled = false
        
        completeNewToDoTableView.delegate = self
        completeNewToDoTableView.dataSource = self
        completeNewToDoTableView.scrollEnabled = false
        
        title = "Settings"
        versionLabel.text = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneButtonPressed:"))
        navigationItem.leftBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonPressed(barButton: UIBarButtonItem) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == capitalizeTableView {
            
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            
            if indexPath.row == 0 {
                capitalizeCell.textLabel?.text = "No do not Capitalize"
                if !NSUserDefaults.standardUserDefaults().boolForKey("capitalize") {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
                capitalizeCell.textLabel?.text = "Yes Capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey("capitalize") {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return capitalizeCell
            
        } else {
            
            var completeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewToDoCell") as UITableViewCell
            
            if indexPath.row == 0 {
                completeCell.textLabel?.text = "No do not Complete Task"
                if !NSUserDefaults.standardUserDefaults().boolForKey("complete") {
                    completeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    completeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
                completeCell.textLabel?.text = "Yes Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey("complete") {
                    completeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    completeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return completeCell
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == capitalizeTableView {
            
            return "Capitalize new Task?"
            
        } else {
            
            return "Complete new Task?"
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == capitalizeTableView {
            NSUserDefaults.standardUserDefaults().setBool(indexPath.row != 0, forKey: "capitalize")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(indexPath.row != 0, forKey: "complete")
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
}
