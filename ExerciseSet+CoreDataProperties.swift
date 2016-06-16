//
//  ExerciseSet+CoreDataProperties.swift
//  GymNotes
//
//  Created by Martin  on 16/05/16.
//  Copyright © 2016 Martin . All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ExerciseSet {

    @NSManaged var exerciseName: String?
    @NSManaged var exerciseSetNumber: NSNumber?
    @NSManaged var exerciseRep: String?
    @NSManaged var exerciseWeight: String?
    @NSManaged var exerciseDate: NSDate?
    @NSManaged var exerciseWorkoutName: String?
    
    
    func nextSetNumber(currentNumber:Int) -> NSNumber {
        
        exerciseSetNumber = currentNumber + 1
        
        return exerciseSetNumber!
    }

}
