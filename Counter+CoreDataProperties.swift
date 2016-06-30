//
//  Counter+CoreDataProperties.swift
//  GymNotes
//
//  Created by Martin  on 30/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Counter {

    @NSManaged var name: String?
    @NSManaged var rounds: String?

}
