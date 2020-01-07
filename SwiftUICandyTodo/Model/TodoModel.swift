//
//  TodoModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

struct TestTodo: Identifiable {
    var id = UUID()
    var title: String
    var completed: Bool
    var due: Date
    
    static var examples: [TestTodo] {
        return [
            TestTodo(title: "Read Type Guidelines", completed: false, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            TestTodo(title: "Complete Responsive Design", completed: false, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            TestTodo(title: "Bring Groceries", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            TestTodo(title: "Take Muffay for walk", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            TestTodo(title: "Talk to Pamela and Betty", completed: true, due: Date(timeIntervalSince1970: 1578070800)), // 01.03
            TestTodo(title: "Clean room", completed: false, due: Date(timeIntervalSince1970: 1578142800)), // 01.04
            TestTodo(title: "Take Abby to Doctor", completed: false, due: Date(timeIntervalSince1970: 1578146400)), // 01.04
            TestTodo(title: "Sleep in the afternoon", completed: false, due: Date(timeIntervalSince1970: 1578232800)), // 01.05
            TestTodo(title: "Talk to Mom", completed: false, due: Date(timeIntervalSince1970: 1578243600)), // 01.05
            TestTodo(title: "Study UI/UX Design", completed: false, due: Date(timeIntervalSince1970: 1578315600)), // 01.06
            TestTodo(title: "Go to Amber Park", completed: false, due: Date(timeIntervalSince1970: 1578402000)) // 01.07
        ]
    }
    
    struct DailyTodo {
        var date: String
        var todos: [Todo]
    }
}



