//
//  Reminder+CoreDataProperties.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 19..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var due: Date
    @NSManaged public var id: String
    @NSManaged public var subtitle: String
    @NSManaged public var title: String
    
}
