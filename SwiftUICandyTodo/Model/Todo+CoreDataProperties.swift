//
//  Todo+CoreDataProperties.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 06..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String
    @NSManaged public var due: Date
    @NSManaged public var priority: Int16
    @NSManaged public var completed: Bool
    @NSManaged public var id: UUID?

    struct DailyTodo {
        var date: String
        var todos: [Todo]
    }
}
