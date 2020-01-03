//
//  TodoModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

struct Todo: Identifiable {
    var id = UUID()
    var title: String
    var completed: Bool
    
    static var examples: [Todo] {
        return [
            Todo(title: "Read Type Guidelin", completed: false),
            Todo(title: "Complete Responsive Design", completed: false),
            Todo(title: "Bring Groceries", completed: true),
            Todo(title: "Take Muffay for walk", completed: true),
            Todo(title: "Talk to Pamela and Betty", completed: true)
        ]
    }
}
