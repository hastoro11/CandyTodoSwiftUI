//
//  NotificationViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 12..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

struct SectionedReminder {
    var date: String
    var reminders: [Reminder]
}

class NotificationViewModel: ObservableObject {
    
    //MARK: - properties
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @Published var keepNotificationsForDays: Int {
        didSet {
            UserDefaults.standard.set(keepNotificationsForDays, forKey: "KeepNotificationsForDays")
        }
    }
    @Published var reminders = [SectionedReminder]()
    
    //MARK: - funcs
    func refresh() {
        list()
    }
    
    func list() {
        let request: NSFetchRequest<Reminder> = NSFetchRequest(entityName: "Reminder")
        request.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        do {
            let reminders = try context.fetch(request)
            sectionReminders(reminders)
        } catch {
            print("Error in catching:", error)
        }
    }
    
    private func sectionReminders(_ reminders: [Reminder]) {
        var result = [SectionedReminder]()
        let upperLimit = Calendar.current.date(byAdding: .day, value: -self.keepNotificationsForDays, to: Date()) ?? Date()
        for reminder in reminders {
            if reminder.due > Date() || reminder.due < upperLimit  {
                continue
            }
            
            let date = Utils.dateToString(reminder.due)
            if let index = result.firstIndex(where: {$0.date == date}) {
                result[index].reminders.append(reminder)
            } else {
                result.append(SectionedReminder(date: date, reminders: [reminder]))
            }
        }
        
        self.reminders = result
    }
    
    func listReminders(reminders: FetchedResults<Reminder>) -> [SectionedReminder] {
        var result = [SectionedReminder]()
        let upperLimit = Calendar.current.date(byAdding: .day, value: -self.keepNotificationsForDays, to: Date()) ?? Date()
        print("limit", upperLimit)
        for reminder in reminders {
            print("id", reminder.id)            
            if (reminder.due > Date() || reminder.due < upperLimit) {
                continue
            }
            
            let date = Utils.dateToString(reminder.due)
            if let index = result.firstIndex(where: {$0.date == date}) {
                result[index].reminders.append(reminder)
            } else {
                result.append(SectionedReminder(date: date, reminders: [reminder]))
            }
        }
        
        return result
    }
    
    init() {
        keepNotificationsForDays = UserDefaults.standard.integer(forKey: "KeepNotificationsForDays")
        
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            for n in notifications {
                print("delivered", n.request.content.subtitle, n.date)
            }
        }
        NotificationCenter.default.publisher(for: Notification.Name.NSManagedObjectContextDidSave, object: nil)
        
    }
}
