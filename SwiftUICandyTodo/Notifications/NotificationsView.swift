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
    var body: some View {
        ZStack {
            Color("Pink")
            .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "NOTIFICATIONS", subtitle: "Alert and updates")
                    List {
                        ForEach(Utils.notifications(notifications), id:\.date) { dailyNotification in
                            
                            Section(header: SectionHeader(title: dailyNotification.date)) {
                                ForEach(dailyNotification.notifications) {notification in
                                    NotificationListViewRow(notification: notification)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
