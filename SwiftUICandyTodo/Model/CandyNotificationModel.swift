//
//  CandyNotification.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

struct CandyNotification: Identifiable {
    var id = UUID()
    var date: String
    var message: String
    
    static var examples: [CandyNotification] {
        return [
            CandyNotification(date: "Today", message: "Hurray! You have completed all tasks for today!"),
            CandyNotification(date: "Today", message: "A new update is available"),
            CandyNotification(date: "Yesterday", message: "Hurray! You have completed all tasks for today!"),
            CandyNotification(date: "Yesterday", message: "You missed one task yesterday")
        ]
    }
}

struct DailyCandyNotification {
    var date: String
    var notifications: [CandyNotification]
}
