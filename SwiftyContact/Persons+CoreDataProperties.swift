//
//  Persons+CoreDataProperties.swift
//  SwiftyContact
//
//  Created by Demond Childers on 5/10/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Persons {

    @NSManaged var personFirstName: String?
    @NSManaged var personLastName: String?
    @NSManaged var personPhone: String?
    @NSManaged var personEmail: String?
    @NSManaged var personAddress: String?

}
