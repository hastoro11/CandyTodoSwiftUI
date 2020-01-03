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
    var due: Date
    
    static var examples: [Todo] {
        return [
            Todo(title: "Read Type Guidelines", completed: false, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            Todo(title: "Complete Responsive Design", completed: false, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            Todo(title: "Bring Groceries", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            Todo(title: "Take Muffay for walk", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            Todo(title: "Talk to Pamela and Betty", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            Todo(title: "Clean room", completed: false, due: Date(timeIntervalSince1970: 1578142800)), // 01.04
            Todo(title: "Take Abby to Doctor", completed: false, due: Date(timeIntervalSince1970: 1578146400)), // 01.04
            Todo(title: "Sleep in the afternoon", completed: false, due: Date(timeIntervalSince1970: 1578232800)), // 01.05
            Todo(title: "Talk to Mom", completed: false, due: Date(timeIntervalSince1970: 1578243600)), // 01.05
            Todo(title: "Study UI/UX Design", completed: false, due: Date(timeIntervalSince1970: 1578315600)), // 01.06
            Todo(title: "Go to Amber Park", completed: false, due: Date(timeIntervalSince1970: 1578402000)) // 01.07
        ]
    }
}


struct DailyTodo {
    var date: String
    var todos: [Todo]
}
