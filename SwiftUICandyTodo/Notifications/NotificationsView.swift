//
//  NotificationsView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct NotificationsView: View {
    var notifications = CandyNotification.examples
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @State var sectionedNotifications: [LocalNotificationManager.SectionedNotification] = []
    var body: some View {
        ZStack {
            Color("Pink")
            .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "NOTIFICATIONS", subtitle: "Alert and updates")
                    List {
                        ForEach(sectionedNotifications, id:\.date) { dailyNotification in
                            
                            Section(header: SectionHeader(title: dailyNotification.date)) {
                                ForEach(dailyNotification.notifications, id:\.self) {notification in
                                    HStack(spacing: 30) {
                                        InfoView()
                                        Text(notification)
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
        }
        .onAppear {
            self.localNotificationManager.listDeliverNotifications(completion: { notifications in
                self.sectionedNotifications = notifications
            })
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
