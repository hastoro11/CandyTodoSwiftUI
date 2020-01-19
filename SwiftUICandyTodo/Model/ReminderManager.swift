//
//  ReminderManager.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 19..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class ReminderManager {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addReminder(id: String, title: String, subtitle: String, due: Date) {
        let reminder = Reminder(context: context)
        reminder.id = id
        reminder.title = title
        reminder.subtitle = subtitle
        reminder.due = due
        
        do {
            try context.save()
            scheduleNotification(reminder: reminder)
        } catch {
            print("Error saving:", error)
        }
    }
    
    private func scheduleNotification(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.subtitle = reminder.subtitle
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 0, to: reminder.due) ?? reminder.due
        let year = calendar.component(.year, from: date) as Int
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func removeReminder(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        deleteReminder(id: id)
    }
    
    private func deleteReminder(id: String) {
        let request: NSFetchRequest<Reminder> = NSFetchRequest(entityName: "Reminder")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let objects = try context.fetch(request)
            context.delete(objects[0])
            try context.save()
        } catch {
            print("Error deleting reminder:", error)
        }
    }        
}
