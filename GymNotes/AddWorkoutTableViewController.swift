//
//  AddRoutineTableViewController.swift
//  Prototype
//
//  Created by Martin  on 05/04/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class AddWorkoutTableViewController: UITableViewController, UITextFieldDelegate {
    
    var color = UIColor(hue: 359, saturation: 0, brightness: 0.31, alpha: 1.0) // Default Grey Color
    
    
    @IBOutlet weak var addWorkoutNameTxt: UITextField!
    
    @IBOutlet weak var saveWorkoutBtn: UIBarButtonItem!
 
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var eWorkout: Workout? = nil
    
    
    @IBAction func saveWorkoutBtn(sender: AnyObject) {
        
        
        let context = self.context
        let ent = NSEntityDescription.entityForName("Workout", inManagedObjectContext: context)
        let eWorkout = Workout(entity: ent!, insertIntoManagedObjectContext: context)
        
        eWorkout.workoutName = addWorkoutNameTxt.text
        
        let currentDate = NSDate()
        
        eWorkout.workoutDate = currentDate
        eWorkout.workoutColorTag = color

        do {
            
            try context.save()
            
        } catch {
            return
        }
        
        dismissVC()
        
    }
    
    
    // Go back to Routine tableview on "save"
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        
        addWorkoutNameTxt.delegate = self
      
        saveWorkoutBtn.enabled = false
        
        addWorkoutNameTxt.addTarget(self, action: #selector(AddWorkoutTableViewController.txtEditing(_:)), forControlEvents: UIControlEvents.EditingChanged)

        self.addWorkoutNameTxt.becomeFirstResponder()
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func txtEditing(textField: UITextField) {
        let length = addWorkoutNameTxt.text?.characters.count
        if length > 0 {
            saveWorkoutBtn.enabled = true
        } else {
            saveWorkoutBtn.enabled = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 25
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        if indexPath.row == 0 {
            color = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0) //Green
        }
        if indexPath.row == 1 {
            color = UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0) //Red
        }
        if indexPath.row == 2 {
            color = UIColor(hue: 0.0222, saturation: 0.72, brightness: 0.91, alpha: 1.0) //Orange
        }
        
        if indexPath.row == 3 {
            color = UIColor(hue: 0.5444, saturation: 0.72, brightness: 0.85, alpha: 1.0) // Blue
        }
        
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    
    
    
    
}
