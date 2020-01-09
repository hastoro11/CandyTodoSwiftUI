//
//  TodoManager.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 09..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

class TodoManager: ObservableObject {
    var context: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        
        NotificationCenter.default.addObserver(self, selector: #selector(todaysTodos), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    @Published var todos = [Todo]()
    
    @objc func todaysTodos() {
        let fetchRequest: NSFetchRequest<Todo> = NSFetchRequest(entityName: "Todo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        let dateFrom = Calendar.current.startOfDay(for: Date())
        let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        
        fetchRequest.predicate = NSPredicate(format: "%K BETWEEN {%@, %@}", "due", dateFrom as NSDate, dateTo as NSDate)
        
        do {
            let todos = try context.fetch(fetchRequest)
            self.todos = todos
        } catch {
            print("Error fetching:", error)
        }
    }
    
    func saveTodo(id: UUID, title: String, due: Date, completed: Bool, getNotified: Bool, priority: Int) {
        let newTodo = Todo(context: context)
        newTodo.id = id
        newTodo.title = title
        newTodo.due = due
        newTodo.completed = completed
        newTodo.getNotified = getNotified
        newTodo.priority = Int16(priority)
        
        try? context.save()
    }
    
}
