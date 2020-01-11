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
            todo.completed.toggle()
            try? self.context.save()
                
    }
    
    func delete(_ todo: Todo) {
        let todoId = todo.objectID
        context.perform {
            let todo = self.context.object(with: todoId)
            self.context.delete(todo)
            try? self.context.save()
        }
    }
}
