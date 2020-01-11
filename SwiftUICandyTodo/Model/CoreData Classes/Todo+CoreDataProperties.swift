//
//  Todo+CoreDataProperties.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var due: Date
    @NSManaged public var id: UUID?
    @NSManaged public var priority: Int16
    @NSManaged public var title: String
    @NSManaged public var getNotified: Bool

    struct DailyTodo {
        var date: String
        var todos: [Todo]
    }
}
