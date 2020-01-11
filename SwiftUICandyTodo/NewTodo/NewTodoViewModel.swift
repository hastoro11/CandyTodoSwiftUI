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
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var title = ""
    @Published var due = Date()
    @Published var priority = Priority.medium.rawValue
    @Published var getNotified = true

    var isButtonDisabled: Bool {
        return title.isEmpty
    }
    
    func saveTodo() {
        let id = UUID()
        let newTodo = Todo(context: context)
        newTodo.id = id
        newTodo.title = title
        newTodo.due = due
        newTodo.completed = false
        newTodo.getNotified = getNotified
        newTodo.priority = Int16(priority)
        
        try? context.save()
    }
}
