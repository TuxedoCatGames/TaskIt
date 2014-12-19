//
//  Date.swift
//  TaskIt
//
//  Created by Bob Keifer on 12/19/14.
//  Copyright (c) 2014 BitFountain. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year: Int, month: Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var calendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = calendar?.dateFromComponents(components)
        
        return date!
    }
    
    class func toString(#date: NSDate) -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        return formatter.stringFromDate(date)
    }
}