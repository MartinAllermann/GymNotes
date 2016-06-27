//
//  CountDownTimerViewController.swift
//  GymNotes
//
//  Created by Martin  on 25/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class CountDownTimerViewController: UIViewController {

    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var startTimerLabel: UIButton!
    
    
    var newDate = NSDate()
    var timer : NSTimer?
    var startTimer: Bool = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startTimerBtn(sender: AnyObject) {
        
        if startTimer == true {
            
            let currentDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
            
            let components = NSDateComponents()
            components.year = dateComponents.year
            components.month = dateComponents.month
            components.day = dateComponents.day
            components.weekOfYear = dateComponents.weekOfYear
            components.hour = dateComponents.hour
            components.minute = dateComponents.minute
            components.second = dateComponents.second + 5
            newDate = calendar.dateFromComponents(components)!
            
            print(currentDate)
            print(newDate)
            
            setTimeLeft()
            
            // Start timer
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.setTimeLeft), userInfo: nil, repeats: true)
            
            startTimerLabel.setTitle("Stop", forState: UIControlState.Normal)
            startTimer = false
            
        } else if startTimer == false {
            
            timer?.invalidate()
            startTimerLabel.setTitle("Start", forState: UIControlState.Normal)
            startTimer = true
        }
        
    }

    func setTimeLeft() {
        
        let currentDate = NSDate()
        let calendar2 = NSCalendar.currentCalendar()
        let components2 = calendar2.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate, toDate: newDate, options: [])
        print(components2.second)
        
        if (components2.second >= 0) {
        
        let timeString = String(format:"%02d:%02d:%02d",components2.hour,components2.minute,components2.second)
        timeLeftLabel.text = timeString
            
        } else {
        
        timer?.invalidate()
        startTimerLabel.setTitle("Start", forState: UIControlState.Normal)
        startTimer = true
        
        }

    }

}