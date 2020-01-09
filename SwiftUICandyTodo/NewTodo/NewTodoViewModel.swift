//
//  NewTodoViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 06..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class NewTodoViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var due = Date()
    @Published var priority = Priority.medium.rawValue
    @Published var getNotified = true

    var isButtonDisabled: Bool {
        return title.isEmpty
    }
    
    func saveTodo(todoManager: TodoManager, localNotificationManager: LocalNotificationManager) {
        let id = UUID()
        todoManager.saveTodo(id: id, title: self.title, due: self.due, completed: false, getNotified: self.getNotified, priority: self.priority)        
        
        if getNotified {
            localNotificationManager.addNotification(id: id.uuidString, title: "Reminder", subtitle: title, due: due)
        }
    }
    
}
