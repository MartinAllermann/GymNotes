//
//  AddExerciseTableViewController.swift
//  Prototype
//
//  Created by Martin  on 06/04/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class AddExerciseTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var saveExerciseBtn: UIBarButtonItem!
    
    @IBOutlet weak var exerciseNameTxt: UITextField!
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var eWorkout: Workout? = nil
    var eExercise: Exercise? = nil
    
    @IBAction func saveExerciseBtn(sender: AnyObject) {
        
        let context = self.context
        let ent = NSEntityDescription.entityForName("Exercise", inManagedObjectContext: context)
        let eExercise = Exercise(entity: ent!, insertIntoManagedObjectContext: context)
        
        eExercise.exerciseName = exerciseNameTxt.text
        eExercise.exerciseWorkoutName = eWorkout?.workoutName
        
        let currentDate = NSDate()
        eExercise.exerciseDate = currentDate
        
        do {
            
            try context.save()
            
        } catch {
            return
        }
        
        dismissVC()
    }
  
    
    @IBAction func saveExercise(sender: AnyObject) {
      
        
    }
    
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    override func viewDidLoad() {
        exerciseNameTxt.delegate = self
        self.exerciseNameTxt.becomeFirstResponder()
        
        saveExerciseBtn.enabled = false
        
        exerciseNameTxt.addTarget(self, action: #selector(AddExerciseTableViewController.txtEditing(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        
        
        super.viewDidLoad()
    }
    
    
    func txtEditing(textField: UITextField) {
        let length = exerciseNameTxt.text?.characters.count
        if length > 0 {
            saveExerciseBtn.enabled = true
        } else {
            saveExerciseBtn.enabled = false
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
    
}
