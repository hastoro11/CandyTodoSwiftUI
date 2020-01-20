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
    var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - properties

    
    @Published var keepNotificationsForDays: Int {
        didSet {
            UserDefaults.standard.set(keepNotificationsForDays, forKey: "KeepNotificationsForDays")            
        }
    }
    
    @Published var sendNotifications: Bool {
        didSet {
            UserDefaults.standard.set(sendNotifications, forKey: "SendNotifications")
        }
    }

    //MARK: - init
    init() {
        keepNotificationsForDays = max(UserDefaults.standard.integer(forKey: "KeepNotificationsForDays"), 1)
        
        sendNotifications = UserDefaults.standard.bool(forKey: "SendNotifications")
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
    
    
    
    
}
