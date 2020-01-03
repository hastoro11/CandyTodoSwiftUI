//
//  Utils.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

class Utils {
    
    static func dateToString(_ dt: Date) -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let difference = dt.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate
        
        if difference < 24 * 60 * 60 {
            return "Today"
        } else if difference < 2 * 24 * 60 * 60 {
            return "Tomorrow"
        } else {
            return formatter.string(from: dt)
        }
    }

    static func upcomingTodos(_ todos: [Todo]) -> [Date: [Todo]] {
        let todos = todos.filter({!Calendar.current.isDateInToday($0.due)})
        var list = [Date: [Todo]]()

        for todo in todos {
            if list.keys.contains(where: { (dt) -> Bool in
                dt == dayFromDate(todo.due)
            }) {
                list[dayFromDate(todo.due)]?.append(todo)
            } else {
                list[dayFromDate(todo.due)] = [todo]
            }
        }
        
        return list
    }
    
    private static func dayFromDate(_ dt: Date) -> Date {
        let componens = Calendar.current.dateComponents(in: .current, from: dt)
        return Calendar.current.date(from: DateComponents(year: componens.year, month: componens.month, day: (componens.day ?? 0) + 1))!
    }

}

