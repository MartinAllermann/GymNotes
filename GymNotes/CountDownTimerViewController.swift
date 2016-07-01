//
//  CountDownTimerViewController.swift
//  GymNotes
//
//  Created by Martin  on 25/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class CountDownTimerViewController: UIViewController, NSFetchedResultsControllerDelegate  {

    @IBOutlet weak var timeLeftLabel: UILabel!
   
    @IBOutlet weak var startTimerLabel: UIButton!
    
    @IBOutlet weak var roundCountBtn: UIButton!
    
    @IBOutlet weak var saveBtnLabel: UIBarButtonItem!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    
    var wodName: String?
    var newDate = NSDate()
    var timer : NSTimer?
    var hour = 0
    var minute = 1
    var startTimer: Bool = true
    var roundCount = 0
    var previousRoundsIsEmpty: Bool = true
   
    @IBAction func cancelBtn(sender: AnyObject){
        timer?.invalidate()
        dismissVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datepickerDate.backgroundColor = UIColor.whiteColor()
        datepickerDate.hidden = false
        timeLeftLabel.hidden = true
        getPreviousTime()
        
        saveBtnLabel.enabled = false
        
        
    }
    
    

    
    @IBAction func saveBtn(sender: AnyObject) {
        
        if previousRoundsIsEmpty == true {
            
            saveTime()
            
        } else if previousRoundsIsEmpty == false {
            
            updateSavedTime()
            
        }
        
    }
    
    
    @IBAction func roundCountBtn(sender: AnyObject) {
        roundCount += 1
        roundCountBtn.setTitle("\(roundCount)", forState: UIControlState.Normal)
        roundCountBtn.titleLabel?.font =  UIFont(name: "Helvetica", size: 40)
        saveBtnLabel.enabled = true
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var datepickerDate: UIDatePicker!
    
    @IBAction func datePicker(sender: AnyObject) {
        
      
    }
    
    func setTimeFromDatePicker() {
        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: datepickerDate.date)
        hour = dateComponents.hour
        minute = dateComponents.minute
        print(datepickerDate.date)
    
    }
    
 
    
    @IBAction func startTimerBtn(sender: AnyObject) {
        
        if startTimer == true {

            setTimeFromDatePicker()
            
            let currentDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
            
            let components = NSDateComponents()
            components.year = dateComponents.year
            components.month = dateComponents.month
            components.day = dateComponents.day
            components.weekOfYear = dateComponents.weekOfYear
            components.hour = dateComponents.hour + hour
            components.minute = dateComponents.minute + minute
            components.second = dateComponents.second
            newDate = calendar.dateFromComponents(components)!
            
            print(currentDate)
            print(newDate)
            
            setTimeLeft()
            
            // Start timer
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.setTimeLeft), userInfo: nil, repeats: true)
            
            startTimerLabel.setTitle("Stop", forState: UIControlState.Normal)
            startTimerLabel.backgroundColor = UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
            startTimer = false
            
            
            datepickerDate.hidden = true
            timeLeftLabel.hidden = false
            
        } else if startTimer == false {
            
            timer?.invalidate()
            startTimerLabel.setTitle("Start", forState: UIControlState.Normal)
            startTimerLabel.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
            startTimer = true
            timeLeftLabel.text = "00:00:OO"
            datepickerDate.hidden = false
            timeLeftLabel.hidden = true
            
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
        startTimerLabel.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        startTimer = true
        datepickerDate.hidden = false
        timeLeftLabel.hidden = true
        
        }

    }
    
    func saveTime(){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let ent = NSEntityDescription.entityForName("Counter", inManagedObjectContext: context)
        let eWod = Counter(entity: ent!, insertIntoManagedObjectContext: context)
        
        eWod.name = wodName
        eWod.rounds = "\(roundCount)"
        
        do {
            
            try context.save()
            getPreviousTime()
            dismissVC()
        } catch {
            return
        }
        
    }
    
    
    func getPreviousTime() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let con: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Counter")
        request.predicate = NSPredicate(format: "name = %@", wodName!)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try con.executeFetchRequest(request) as! [Counter]
            
            for res in results {
                highscoreLabel.text = "Highscore: " + "\(res.rounds!)"
                previousRoundsIsEmpty = false
                
            }
            
        } catch {
            print("Unresolved error")
            abort()
        }
    }
    
    func updateSavedTime(){
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Counter")
        request.predicate = NSPredicate(format: "name = %@", wodName!)
        
        if let fetchResults = (try? appDel.managedObjectContext.executeFetchRequest(request)) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                let managedObject = fetchResults[0]
                managedObject.setValue("\(roundCount)", forKey: "rounds")
                
                do {
                    try context.save()
                    getPreviousTime()
                    dismissVC()
                } catch {
                    return
                }
            }
        }
        
    }
    
    // Go back on "save"
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
        
    }

}
