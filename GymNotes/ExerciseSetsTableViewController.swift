//
//  SetsTableViewController.swift
//  Prototype
//
//  Created by Martin  on 06/04/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class ExerciseSetsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var eExerciseSet: ExerciseSet? = nil
    var eWorkout: Workout? = nil
    var eExercise: Exercise? = nil
    var getNumberOfRows: Int?
    var reloadView: Bool?
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchedRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchedRequest() -> NSFetchRequest {
        
        let pExerciseWorkoutName = eExercise?.exerciseWorkoutName
        let pExerciseName = eExercise?.exerciseName
        
        let fetchRequest = NSFetchRequest(entityName: "ExerciseSet")
        
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", "exerciseName", pExerciseName!, "exerciseWorkoutName", pExerciseWorkoutName!)
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "exerciseSetNumber", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
        
    }
    
    
    override func viewDidLoad() {
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ExerciseSetsTableViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        self.navigationItem.title = eExercise?.exerciseName
        
        super.viewDidLoad()
        
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do {
            
            try frc.performFetch()
            
            
        } catch {
            return
        }
    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Set                     Weight                    Reps"
    }
    
    
    // Update view when new routine is created
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        if reloadView == true {
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (frc.sections?.count)!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        getNumberOfRows = frc.sections?[section].numberOfObjects
        return (frc.sections?[section].numberOfObjects)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseSetCell", forIndexPath: indexPath) as! ExerciseSetsTableViewCell
        let nSet = frc.objectAtIndexPath(indexPath) as! ExerciseSet
        
        // Configure the cell...
        
        let weight = nSet.exerciseWeight!
        let reps = nSet.exerciseRep!
        let set = nSet.exerciseSetNumber!
        
        reloadView = false
        
        cell.setNumberLabel.text = "\(set)"
        
        cell.setWeightTxt.delegate = self
        cell.setWeightTxt.text = weight
        cell.setWeightTxt.tag = set as Int
        cell.setWeightTxt.addTarget(self, action: #selector(ExerciseSetsTableViewController.weightTextFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        
        cell.setRepsTxt.delegate = self
        cell.setRepsTxt.text = reps
        cell.setRepsTxt.tag = set as Int
        cell.setRepsTxt.addTarget(self, action: #selector(ExerciseSetsTableViewController.repsTextFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        reloadView = true
        
        let managedObjectDelete: NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObjectDelete)
        
        do {
            try context.save()
            updateAllSets()
        } catch {
            return
        }
    }
    
    func updateAllSets(){
        
        let pExerciseWorkoutName = eExercise?.exerciseWorkoutName
        let pExerciseName = eExercise?.exerciseName
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let con: NSManagedObjectContext = appDel.managedObjectContext
        
        
        let request = NSFetchRequest(entityName: "ExerciseSet")
        request.predicate = NSPredicate(format: "exerciseWorkoutName = %@ AND exerciseName = %@",pExerciseWorkoutName!, pExerciseName!)
        
        if let fetchResults = (try? appDel.managedObjectContext.executeFetchRequest(request)) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                print(fetchResults.count)
                
                for i in 0 ..< fetchResults.count {
                    
                    let managedObject = fetchResults[i]
                    managedObject.setValue(i+1, forKey: "exerciseSetNumber")
                    
                    do {
                        try con.save()
                    } catch {
                        return
                    }
                    
                    
                    
                }
            }
            
        }
        
    }
    
    
    func repsTextFieldDidChange(textField: UITextField){
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let set = textField.tag
        let pExerciseWorkoutName = eExercise?.exerciseWorkoutName
        let pExerciseName = eExercise?.exerciseName
        
        let request = NSFetchRequest(entityName: "ExerciseSet")
        request.predicate = NSPredicate(format: "exerciseSetNumber = %@ AND exerciseName = %@ AND exerciseWorkoutName = %@", "\(set)", pExerciseName!, pExerciseWorkoutName!)
        
        if let fetchResults = (try? appDel.managedObjectContext.executeFetchRequest(request)) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                let managedObject = fetchResults[0]
                managedObject.setValue(textField.text, forKey: "exerciseRep")
                
                do {
                    try context.save()
                } catch {
                    return
                }
            }
        }
        
    }
    
    func weightTextFieldDidChange(textField: UITextField) {
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let set = textField.tag
        let pExerciseWorkoutName = eExercise?.exerciseWorkoutName
        let pExerciseName = eExercise?.exerciseName
        
        let request = NSFetchRequest(entityName: "ExerciseSet")
        request.predicate = NSPredicate(format: "exerciseSetNumber = %@ AND exerciseName = %@ AND exerciseWorkoutName = %@", "\(set)", pExerciseName!, pExerciseWorkoutName!)
        
        if let fetchResults = (try? appDel.managedObjectContext.executeFetchRequest(request)) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                let managedObject = fetchResults[0]
                managedObject.setValue(textField.text, forKey: "exerciseWeight")
                
                do {
                    try context.save()
                } catch {
                    return
                }
            }
        }
        
    }
    @IBOutlet weak var addSetBtn: UIButton!
    @IBAction func addNewSetBtn(sender: AnyObject) {
        
        reloadView = true
        
        let context = self.context
        let ent = NSEntityDescription.entityForName("ExerciseSet", inManagedObjectContext: context)
        let createSet = ExerciseSet(entity: ent!, insertIntoManagedObjectContext: context)
        
        createSet.exerciseWeight = ""
        createSet.exerciseRep = ""
        createSet.exerciseName = eExercise?.exerciseName
        createSet.exerciseWorkoutName = eExercise?.exerciseWorkoutName
        createSet.nextSetNumber(getNumberOfRows!)
        
        let currentDate = NSDate()
        createSet.exerciseDate = currentDate
        
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 8
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    
    
}
