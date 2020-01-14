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
    
    @FetchRequest(entity: Notification.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)]) var notifications: FetchedResults<Notification>
    var localNotificationManager = LocalNotificationManager()
    @ObservedObject var viewModel = NotificationViewModel()
    private var didSavePublisher = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    @State var refreshing = false
    var body: some View {
        ZStack {
            Color("Pink")
            .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "NOTIFICATIONS", subtitle: "Received alerts")
                    List {
                        ForEach(viewModel.listNotifications(notifications: notifications), id:\.date) { dailyNotification in
                            
                            Section(header: SectionHeader(title: dailyNotification.date)) {
                                ForEach(dailyNotification.notifications, id:\.self) {notification in
                                    HStack(spacing: 30) {
                                        InfoView()
                                        Text("\(notification.title + (self.refreshing ? "" : "")) : \(notification.subtitle)")
                                            .font(.custom("Avenir-Book", size: 16))
                                            .foregroundColor(Color("Dark Blue"))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                .contextMenu(menuItems: {
                                    Button(action: {
                                        self.viewModel.deleteNotifocation(notification)
                                    }, label: {
                                        Image(systemName: "trash")
                                        Text("Delete")
                                    })
                                })
                                }
                            }
                        }
                    }
                    
                }
            }
            .onReceive(self.didSavePublisher, perform: {_ in
                self.refreshing.toggle()
            })
        }
    }
}
//
//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}
