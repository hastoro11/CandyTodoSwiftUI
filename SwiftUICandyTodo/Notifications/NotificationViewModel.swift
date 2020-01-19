//
//  NotificationViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 12..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

class NotificationViewModel: ObservableObject {
    
    //MARK: - properties
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    struct SectionedNotification {
        var date: String
        var notifications: [Notification]
    }
    
    @Published var keepNotificationsForDays: Int {
        didSet {
            UserDefaults.standard.set(keepNotificationsForDays, forKey: "KeepNotificationsForDays")
        }
    }
    //MARK: - funcs
    func listNotifications(notifications: FetchedResults<Notification>) -> [SectionedNotification] {
        var result = [SectionedNotification]()
        let upperLimit = Calendar.current.date(byAdding: .day, value: -self.keepNotificationsForDays, to: Date()) ?? Date()
        print("limit", upperLimit)
        for notification in notifications {
            print(notification.due)
            if notification.due > Date() || notification.due < upperLimit  {
                continue
            }
            let date = Utils.dateToString(notification.due)
            if let index = result.firstIndex(where: {$0.date == date}) {
                result[index].notifications.append(notification)
            } else {
                result.append(SectionedNotification(date: date, notifications: [notification]))
            }
        }
        
        return result
    }
    
    init() {
        keepNotificationsForDays = UserDefaults.standard.integer(forKey: "KeepNotificationsForDays")
    }
}
