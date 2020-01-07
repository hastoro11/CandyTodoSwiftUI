//
//  NewTodoViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 06..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import Combine
import CoreData

class NewTodoViewModel: ObservableObject {
    
    var localNotificationmanager = LocalNotificationManager()
    
    @Published var title = ""
    @Published var due = Date()
    @Published var priority = Priority.medium.rawValue
    @Published var getNotified = true
    
    var isButtonDisabled: Bool {
        return title.isEmpty
    }
    
    func saveTodo(context: NSManagedObjectContext) {
        let newTodo = Todo(context: context)
        newTodo.title = self.title
        newTodo.due = self.due
        newTodo.completed = false
        newTodo.getNotified = self.getNotified
        newTodo.priority = Int16(self.priority)
        
        if getNotified {
            let notification = LocalNotificationManager.Notification(title: self.title, due: self.due)
            localNotificationmanager.addNotification(notification)
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving:", error)
        }
    }
}
