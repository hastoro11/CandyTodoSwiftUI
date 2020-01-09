//
//  Notification+CoreDataProperties.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 09..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//
//

import Foundation
import CoreData


extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var subtitle: String
    @NSManaged public var due: Date

}
