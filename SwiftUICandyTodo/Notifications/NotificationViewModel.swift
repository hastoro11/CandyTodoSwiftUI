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
    //MARK: - funcs
    func listNotifications(notifications: FetchedResults<Notification>) -> [SectionedNotification] {
        var result = [SectionedNotification]()
        for notification in notifications {
            if notification.due > Date() {
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
    
    func deleteNotifocation(_ notification: Notification) {
        context.delete(notification)
        try? context.save()
    }
}
