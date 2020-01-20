//
//  TodoListViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 10..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

struct DailyTodo {
    var date: String
    var todos: [Todo]
}

class TodoListViewModel: ObservableObject {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var reminderManager = ReminderManager()
    
    static var upcomingPredicate: NSPredicate = {
        let dateFrom = Calendar.current.startOfDay(for: Date())
        let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        
        return NSPredicate(format: "%K > %@", "due", dateTo as NSDate)
    }()
    
    static var todayPredicate: NSPredicate = {
        let dateFrom = Calendar.current.startOfDay(for: Date())
        let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        
        return NSPredicate(format: "%K BETWEEN {%@, %@}", "due", dateFrom as NSDate, dateTo as NSDate)
    }()
    
    func createUpcomingTodos(_ todos: FetchedResults<Todo>) -> [DailyTodo] {
        
        var result = [DailyTodo]()
        for todo in todos {
            
            let date = Utils.dateToString(todo.due)
            if let index = result.firstIndex(where: {$0.date == date}) {
                result[index].todos.append(todo)
            } else {
                result.append(DailyTodo(date: date, todos: [todo]))
            }
        }
        return result
    }
    
    
    func toggleCompleted(_ todo: Todo) {
        if !todo.getNotified { return }
        todo.completed.toggle()
        if todo.completed, let id = todo.id?.uuidString {
            reminderManager.removeReminder(id: id)
        }
        if !todo.completed, let id = todo.id?.uuidString {
            reminderManager.addReminder(id: id, title: "Reminder", subtitle: todo.title, due: todo.due)
        }
        try? self.context.save()
        
    }
    
    func delete(_ todo: Todo) {
        self.context.delete(todo)
        reminderManager.removeReminder(id: todo.id!.uuidString)        
        try? self.context.save()
    }
}

struct UpcomingTodo {
    var objectID: NSManagedObjectID
    var completed: Bool
    var title: String
}
