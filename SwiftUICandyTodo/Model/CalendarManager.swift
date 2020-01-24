//
//  CalendarManager.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 21..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import EventKit

class CalendarManager {
        
    let eventStore = EKEventStore()
    
    func checkAuthorization(completion: @escaping (Bool) -> Void) {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            completion(true)
        default:
            eventStore.requestAccess(to: .event) { (success, error) in
                DispatchQueue.main.async {
                    completion(success)
                }
                
            }
        }
    }
    
    func saveIntoCalendar(title: String, startDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = startDate.addingTimeInterval(30 * 60)
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            print("Error saving in calendar:", error)
        }
    }
    
}
