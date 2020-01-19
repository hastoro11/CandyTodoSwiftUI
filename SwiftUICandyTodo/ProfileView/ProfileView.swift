//
//  ProfileView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var context
    @ObservedObject var localNotificationManager = LocalNotificationManager()
        
    @State var vibrateOnAlert = true
    @State var showEditProfile = false
    @State var keepNotificationsForDays = 3
    var body: some View {
        let sendNotifications = Binding<Bool>(get: {
            return self.localNotificationManager.sendNotifications
        }, set: {
            self.localNotificationManager.sendNotifications = $0
            if $0 {
                self.localNotificationManager.checkAuthorization()
            } else {
                self.localNotificationManager.cancelNotifications()
            }
        })
        return VStack {
            ProfileTitleView(title: "PROFILE", user: users.first, showEditProfile: $showEditProfile)
            
            List {
                Section(header: SectionHeader(title: "Notification Settings")) {
                    HStack {
                        Text("Send notifications")
                            .foregroundColor(Color("Dark Blue"))
                            .font(.custom("Avenir-Book", size: 16))
                        Toggle(isOn: sendNotifications, label: {
                            Text("")
                        })
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
//                    HStack {
//                        Text("Vibrate on alert")
//                            .foregroundColor(Color("Dark Blue"))
//                            .font(.custom("Avenir-Book", size: 16))
//                        Toggle(isOn: $vibrateOnAlert, label: {
//                            Text("")
//                        })
//                    }
//                    .padding(.horizontal, 30)
//                    .padding(.bottom, 20)
                    HStack {
                        Group {
                            Text("Keep notifications for ") + Text("\(localNotificationManager.keepNotificationsForDays)").bold() + Text(" of days")
                        }
                        .foregroundColor(Color("Dark Blue"))
                        .font(.custom("Avenir-Book", size: 16))
                        Stepper("", value: $localNotificationManager.keepNotificationsForDays, in: (1...7))
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                EditProfileView(user: self.users.first)
                    .environment(\.managedObjectContext, self.context)
            })
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
