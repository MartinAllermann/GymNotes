//
//  TableViewController.swift
//  Prototype
//
//  Created by Martin  on 04/04/16. Time to commit again
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit
import CoreData

class WorkoutsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    let context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchedRequest(), managedObjectContext: context, sectionNameKeyPath: "workoutDate", cacheName: nil)
        return frc
    }
    
    func listFetchedRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Workout")
        let sortDescriptor = NSSortDescriptor(key: "workoutDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 0
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do {
            
            try frc.performFetch()
            
        } catch {
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("workoutCell", forIndexPath: indexPath) as! workoutsTableViewCell
        let eWorkout = frc.objectAtIndexPath(indexPath) as! Workout
        
        // Configure the cell...
        
        cell.workoutLabel.text = eWorkout.workoutName
        cell.workoutColorTagView.backgroundColor = eWorkout.workoutColorTag as? UIColor
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let eWorkout: Workout = frc.objectAtIndexPath(indexPath) as! Workout
        let pWorkoutName = eWorkout.workoutName
        
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let con = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Exercise")
        let predicate = NSPredicate(format: "exerciseWorkoutName == %@", pWorkoutName!)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        
        let appDel2 = UIApplication.sharedApplication().delegate as! AppDelegate
        let con2 = appDel2.managedObjectContext
        let coord2 = appDel2.persistentStoreCoordinator
        
        let fetchRequest2 = NSFetchRequest(entityName: "ExerciseSet")
        let predicate2 = NSPredicate(format: "exerciseWorkoutName == %@", pWorkoutName!)
        fetchRequest2.predicate = predicate2
        
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        let managedObject: NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObject)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: con)
            try coord2.executeRequest(deleteRequest2, withContext: con2)
            try context.save()
        } catch let error as NSError {
            debugPrint(error)
        }
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openWorkout" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController: ExercisesTableViewController = segue.destinationViewController as! ExercisesTableViewController
            let eWorkout: Workout = frc.objectAtIndexPath(indexPath!) as! Workout
            itemController.eWorkout = eWorkout
        }
    }
    
    // remove highlighting of cell on swipe
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}
