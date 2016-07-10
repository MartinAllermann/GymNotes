//
//  wodDescriptionViewController.swift
//  GymNotes
//
//  Created by Martin  on 21/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class wodDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    
    @IBOutlet weak var timerTableView: UITableView!
    var wodName: String?
    var wodType: String?
    var exerciseOne: String?
    var exerciseTwo: String?
    var exerciseThree: String?
    var exerciseFour: String?
    var color: String?
    var timers: [String] = []
    let cellIdentifier = "Cell"
    var savedTimes: [String] = []
    var forTime = "00:00:00"
    var Amrap = "0 Rounds"
    
    @IBOutlet weak var backgroundColor: UIView!
    
    @IBOutlet weak var wodNameLabel: UILabel!
    
    @IBOutlet weak var wodTypeLabel: UILabel!
    
    @IBOutlet weak var exerciseOneLabel: UILabel!
    
    @IBOutlet weak var exerciseTwoLabel: UILabel!
    
    @IBOutlet weak var exerciseThreeLabel: UILabel!
    
    @IBOutlet weak var exerciseFourLabel: UILabel!

    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPreviousTime()
        getPreviousAmrap()
        
        timers = ["For Time", "AMRAP"]
        savedTimes = [forTime, Amrap]
       
        
        
        
        /*
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
 */
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        wodNameLabel.text = wodName
        wodTypeLabel.text = wodType
        exerciseOneLabel.text = exerciseOne
        exerciseTwoLabel.text = exerciseTwo
        exerciseThreeLabel.text = exerciseThree
        exerciseFourLabel.text = exerciseFour
        
        if color == "Green" {
            backgroundColor.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        } else if color == "Blue" {
            backgroundColor.backgroundColor  = UIColor(hue: 0.5444, saturation: 0.72, brightness: 0.85, alpha: 1.0)
        } else if color == "Orange" {
            backgroundColor.backgroundColor  = UIColor(hue: 0.0222, saturation: 0.72, brightness: 0.91, alpha: 1.0)
        } else if color == "Red" {
            backgroundColor.backgroundColor  =  UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
        }


        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        getPreviousTime()
        getPreviousAmrap()
        
        timers = ["For Time", "AMRAP"]
        savedTimes = [forTime, Amrap]
        timerTableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showStopwatch"
        {
            
            let vc = segue.destinationViewController as! TimerViewController
            
            vc.title = wodName
            vc.wodName = wodName
            
        }
        
        if segue.identifier == "showCountdownTimer"
        {
            
            let vc = segue.destinationViewController as! CountDownTimerViewController
            
            vc.title = wodName
            vc.wodName = wodName
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Fetch Fruit
        let time = timers[indexPath.row]
        let savedTime = savedTimes[indexPath.row]
        
        // Configure Cell
        cell.textLabel?.text = time
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.text = savedTime
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("showStopwatch", sender: indexPath);
        } else {
            self.performSegueWithIdentifier("showCountdownTimer", sender: indexPath);
        }
        
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
                forTime = res.time!
                
            }
            
        } catch {
            print("Unresolved error")
            abort()
        }
    }
    
    func getPreviousAmrap() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let con: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Counter")
        request.predicate = NSPredicate(format: "name = %@", wodName!)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try con.executeFetchRequest(request) as! [Counter]
            
            for res in results {
                Amrap = "\(res.rounds!) " + "Rounds"
            
                
            }
            
        } catch {
            print("Unresolved error")
            abort()
        }
    }
    

}
