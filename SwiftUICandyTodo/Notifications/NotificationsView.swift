//
//  NotificationsView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData
import UserNotifications

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    
    @FetchRequest(entity: Reminder.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)]) var reminders: FetchedResults<Reminder>
    
    @State var refreshing = false
    var body: some View {
        ZStack {
            Color("Pink")
            .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "NOTIFICATIONS", subtitle: "Alerts")                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.listReminders(reminders: reminders), id:\.date) { dailyReminder in
                            VStack(alignment: .leading) {
                                SectionHeader(title: dailyReminder.date)
                                ForEach(dailyReminder.reminders, id:\.self) { reminder in
                                    HStack(spacing: 30) {
                                        InfoView()
                                        Text("\(reminder.title + (self.refreshing ? "" : "")) : \(reminder.subtitle)")
                                            .font(.custom("Avenir-Book", size: 16))
                                            .foregroundColor(Color("Dark Blue"))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 45)
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                    
                }
            }
            .onAppear {                
                self.viewModel.refresh()
            }
        }
    }
}
//
//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}
