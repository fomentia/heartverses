//
//  SettingsTableViewController.swift
//  Heart Verses
//
//  Created by Isaac Williams on 7/22/15.
//  Copyright (c) 2015 Isaac Williams. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var reminderSwitch: UISwitch!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let reminderState: AnyObject = defaults.valueForKey("remindersOn") {
            if reminderState as! Bool == true {
                self.reminderSwitch.on = true
            } else {
                self.reminderSwitch.on = false
            }
        }
    }
    
    func createReminder(fireDate: NSDate, title: String, body: String) {
        let notification = UILocalNotification()
        notification.fireDate = fireDate
        notification.alertTitle = title
        notification.alertBody = body
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    @IBAction func reminderSwitchToggled(sender: AnyObject) {0
        if reminderSwitch.on == true {
            defaults.setBool(true, forKey: "remindersOn")
            
            let date = NSDate(timeIntervalSinceNow: 40.0)
            createReminder(date, title: "hello", body: "I am testing")
        } else {
            defaults.setBool(false, forKey: "remindersOn")
        }
    }

}