//
//  LocalNotificationManager.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import UserNotifications

private let key = "LocalNotofications"

class LocalNotificationManager: ObservableObject {
    
    struct Notification: Codable {        
        var title: String
        var due: Date
    }
    
    var notifications = [Notification]()
    
    func addNotification(_ notification: Notification) {
        self.notifications.append(notification)
        
        
        if let data = try? JSONEncoder().encode(self.notifications) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func deleteNotification(title: String, due: Date) {
        let notifications = self.notifications.filter({!($0.title == title && $0.due == due)})
        self.notifications = notifications
        
        if let data = try? JSONEncoder().encode(self.notifications) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let notifications = try? JSONDecoder().decode([Notification].self, from: data) {
                self.notifications = notifications
            }
        } else {
            self.notifications = []
        }
        print("no of notifications", self.notifications.count)
    }
}
