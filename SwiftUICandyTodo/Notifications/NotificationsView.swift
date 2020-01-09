//
//  NotificationsView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notification.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)]) var notifications: FetchedResults<Notification>
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @State var refresh = false
    var body: some View {
        ZStack {
            Color("Pink")
            .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "NOTIFICATIONS", subtitle: "Received alerts" + (refresh ? "" : ""))
                    List {
                        ForEach(LocalNotificationManager.listNotifications(notifications: notifications), id:\.date) { dailyNotification in
                            
                            Section(header: SectionHeader(title: dailyNotification.date)) {
                                ForEach(dailyNotification.notifications, id:\.self) {notification in
                                    HStack(spacing: 30) {
                                        InfoView()
                                        Text("\(notification.title) : \(notification.subtitle)")
                                            .font(.custom("Avenir-Book", size: 16))
                                            .foregroundColor(Color("Dark Blue"))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                    
                }
            }
        }.onAppear {
            self.refresh.toggle()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
