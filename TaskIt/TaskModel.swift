//
//  TaskModel.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/22/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
