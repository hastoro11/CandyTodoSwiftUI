//
//  ProfileView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var user: User = User.example
    @State var sendNotifications = false
    @State var vibrateOnAlert = true
    var body: some View {
        VStack {
            TitleView(title: "PROFILE", user: user)
            
            List {
                Section(header: SectionHeader(title: "Notification Settings")) {
                    HStack {
                        Text("Send notifications")
                            .foregroundColor(Color("Dark Blue"))
                            .font(.custom("Avenir-Book", size: 16))
                        Toggle(isOn: $sendNotifications, label: {
                            Text("")
                        })
                    }
                    .padding(.horizontal, 30)
                    HStack {
                        Text("Vibrate on alert")
                            .foregroundColor(Color("Dark Blue"))
                            .font(.custom("Avenir-Book", size: 16))
                        Toggle(isOn: $vibrateOnAlert, label: {
                            Text("")
                        })
                    }
                    .padding(.horizontal, 30)
                }
            }
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
