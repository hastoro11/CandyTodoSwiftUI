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
    
    //MARK: - properties
    struct Notification: Codable {
        var id: String
        var title: String
        var due: Date
    }
    
    struct SectionedNotification {
        var date: String
        var notifications: [String]
    }

    //MARK: - init
    init() {
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
        content.title = "Reminder"
        content.subtitle = notification.title
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: -30, to: notification.due) ?? notification.due
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print("Added notification")
            if let error = error {
                print("Error adding notification:", error.localizedDescription)
            }
        }
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func removeCompletedNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func addNotification(_ notification: Notification) {
        scheduleNotification(notification)
    }
    
    func listDeliverNotifications(completion: @escaping ([SectionedNotification]) -> Void) {
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { notifications in
            let sortedNotifications = notifications.sorted(by: {$0.date > $1.date})
            var sectionedNotifications = [SectionedNotification]()
            
            for notification in sortedNotifications {
                let date = Utils.dateToString(notification.date)
                if let index = sectionedNotifications.firstIndex(where: {$0.date == date}) {
                    sectionedNotifications[index].notifications.append(notification.request.content.subtitle)
                } else {
                    sectionedNotifications.append(SectionedNotification(date: date, notifications: [notification.request.content.subtitle]))
                }
                
            }
            completion(sectionedNotifications)
        })
    }
}
