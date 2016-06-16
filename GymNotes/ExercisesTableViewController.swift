//
//  routineTableViewController.swift
//  Prototype
//
//  Created by Martin  on 05/04/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class ExercisesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    var eWorkout: Workout? = nil
    
    let context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchedRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchedRequest() -> NSFetchRequest {
        
        let fetchFrom = eWorkout?.workoutName
        
        let fetchRequest = NSFetchRequest(entityName: "Exercise")
        
        let predicate = NSPredicate(format: "%K == %@", "exerciseWorkoutName", fetchFrom!)
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "exerciseDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
        
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.title = eWorkout?.workoutName
        super.viewDidLoad()
        
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do {
            
            try frc.performFetch()
            
        } catch {
            return
        }
    }
    
    
    // Update view when new routine is created
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (frc.sections?.count)!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (frc.sections?[section].numberOfObjects)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ExerciseTableViewCell
        let eExercise = frc.objectAtIndexPath(indexPath) as! Exercise
        
        // Configure the cell...
        
        cell.exercisesLabel.text = eExercise.exerciseName
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newExerciseSegue" {
            
            let itemController: AddExerciseTableViewController = segue.destinationViewController as! AddExerciseTableViewController
            itemController.eWorkout = eWorkout
            
        }
        if segue.identifier == "addSetSegue" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController: ExerciseSetsTableViewController = segue.destinationViewController as! ExerciseSetsTableViewController
            let eExercise: Exercise = frc.objectAtIndexPath(indexPath!) as! Exercise
            itemController.eExercise = eExercise
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exercises"
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let eExercise: Exercise = frc.objectAtIndexPath(indexPath) as! Exercise
        let pExercise = eExercise.exerciseName
        let pWorkout = eWorkout?.workoutName
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let con = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "ExerciseSet")
        let predicate = NSPredicate(format: "exerciseName == %@ And exerciseWorkoutName == %@", pExercise!, pWorkout!)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let managedObject: NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObject)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: con)
            try context.save()
        } catch let error as NSError {
            debugPrint(error)
        }
        
    }
    
    // remove highlighting of cell on swipe
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
