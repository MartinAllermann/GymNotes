//
//  Exercise+CoreDataProperties.swift
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

extension Exercise {

    @NSManaged var exerciseName: String?
    @NSManaged var exerciseWorkoutName: String?
    @NSManaged var exerciseDate: NSDate?

}
