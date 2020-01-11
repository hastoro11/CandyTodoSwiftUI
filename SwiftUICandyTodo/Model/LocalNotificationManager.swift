//
//  LocalNotificationManager.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
import SwiftUI

class LocalNotificationManager: ObservableObject {
    var context: NSManagedObjectContext
    
    //MARK: - properties
    struct SectionedNotification {
        var date: String
        var notifications: [Notification]
    }

    //MARK: - init
    init(_ context: NSManagedObjectContext) {
        self.context = context
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            for r in requests {
                print("pending", r.content.subtitle)
            }
        }
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            for n in notifications {
                print("delivered", n.request.content.subtitle, n.date)
            }
        }
    }
    
    //MARK: - funcs
    func checkAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined, .denied:
                self.requestAuthorization()
            default:
                break
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (success, error) in
            if success && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    private func scheduleNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
        
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func scheduleNotification(_ notification: Notification) {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.subtitle = notification.subtitle
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 0, to: notification.due) ?? notification.due
        let year = calendar.component(.year, from: date) as Int
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error adding notificarion:", error)
            } else {
                print("Notification added")
            }
        }
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        
        let request: NSFetchRequest<Notification> = NSFetchRequest(entityName: "Notification")
        request.predicate = NSPredicate(format: "id == %@", id)
            
        do {
            let notifications = try context.fetch(request)
            context.delete(notifications[0])
        } catch {
            print("Error:", error)
        }
        
    }
    
    func removeCompletedNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
        
    func addNotification(id: String, title: String, subtitle: String, due: Date) {
        let notification = Notification(context: context)
        notification.id = id
        notification.title = title
        notification.subtitle = subtitle
        notification.due = due
        
        try? context.save()
        
        scheduleNotification(notification)
    }
    
    static func listNotifications(notifications: FetchedResults<Notification>) -> [SectionedNotification] {
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
}
