//
//  TodoListViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 10..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

class TodoListViewModel: ObservableObject {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    @Published var todaysTodos: [Todo] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    @objc func refresh() {
        fetchTodaysTodos()
    }
    
    func fetchTodaysTodos(){
        let fetchRequest: NSFetchRequest<Todo> = NSFetchRequest(entityName: "Todo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        let dateFrom = Calendar.current.startOfDay(for: Date())
        let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        
        fetchRequest.predicate = NSPredicate(format: "%K BETWEEN {%@, %@}", "due", dateFrom as NSDate, dateTo as NSDate)
        
        do {
            let todos = try context.fetch(fetchRequest)
            self.todaysTodos = todos
        } catch {
            print("Error fetching:", error)
            self.todaysTodos = []
        }
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
