//
//  TimerViewController.swift
//  GymNotes
//
//  Created by Martin  on 16/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class TimerViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var wodName: String?
    var timer : NSTimer?
    var startTime : NSTimeInterval?
    var accumulatedTime = NSTimeInterval()
    var startStopWatch: Bool = true
    var previousTimeIsEmpty: Bool = true
    
    @IBOutlet weak var previousTime: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var startAndStop: UIButton!
    
    @IBAction func saveBtn(sender: AnyObject) {
        
        if previousTimeIsEmpty == true {
            
            saveTime()
        
        } else if previousTimeIsEmpty == false {
            
            updateSavedTime()
        
        }
        
        
    }
    
    // Go back on "save"
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func resetBtn(sender: AnyObject) {
        
        timer?.invalidate()
        
        startTime = nil
        accumulatedTime = 0
        currentTime.text = "00:00.00"
        
        startStopWatch = true
        startAndStop.setTitle("Start", forState: UIControlState.Normal)
        startAndStop.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        
        /*
                guard self.timer != nil else {
            return
        }
 
        self.timer = nil
 
        */
        
    }
    

    @IBAction func startBtn(sender: AnyObject) {
        
        if startStopWatch == true {
            
            
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
            
            startStopWatch = false
            startAndStop.setTitle("Stop", forState: UIControlState.Normal)
            startAndStop.backgroundColor = UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
            
            
        } else {
            
 
            
            self.timer!.invalidate()
            self.timer = nil

            startStopWatch = true
            startAndStop.setTitle("Start", forState: UIControlState.Normal)
            startAndStop.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getPreviousTime()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        
        let currentTimeStamp = NSDate.timeIntervalSinceReferenceDate()
        let intervalTime = currentTimeStamp - startTime!
        self.startTime = currentTimeStamp
        self.accumulatedTime += intervalTime
        
        var elapsedTime = self.accumulatedTime
        
        
        let minutes = UInt8(elapsedTime / 60)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let timeString = String(format:"%02d:%02d.%02d",minutes,seconds,fraction)
        currentTime.text = timeString
        print(timeString)
        
    }
    
    func getPreviousTime() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let con: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Wod")
        request.predicate = NSPredicate(format: "name = %@", wodName!)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try con.executeFetchRequest(request) as! [Wod]
            
            for res in results {
                previousTime.text = res.time
                previousTimeIsEmpty = false
                
            }
            
        } catch {
            print("Unresolved error")
            abort()
        }
    }
    
    func saveTime(){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let ent = NSEntityDescription.entityForName("Wod", inManagedObjectContext: context)
        let eWod = Wod(entity: ent!, insertIntoManagedObjectContext: context)
        
        eWod.name = wodName
        eWod.time = currentTime.text
        
        do {
            
            try context.save()
            getPreviousTime()
            dismissVC()
        } catch {
            return
        }
    
    }
    
    func updateSavedTime(){
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Wod")
        request.predicate = NSPredicate(format: "name = %@", wodName!)
        
        if let fetchResults = (try? appDel.managedObjectContext.executeFetchRequest(request)) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                let managedObject = fetchResults[0]
                managedObject.setValue(currentTime.text, forKey: "time")
                
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
    

}
