//
//  ContentView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @State var showNewTodoView = false
    
    var body: some View {
        ZStack {
            TabView {
                TodayListView()                
                    .tabItem({
                        Image(systemName: "list.bullet")
                            .font(.system(size: 24))
                    })
                    .tag(0)
                
                UpcomingListView()
                    .tabItem({
                        Image(systemName: "clock")
                            .font(.system(size: 24))
                    })
                    .tag(1)
                
                Text("")
                    .tabItem({
                        Text("")
                            .font(.system(size: 24))
                    })
                
                
                NotificationsView()
                    .tabItem({
                        Image(systemName: "bell")
                            .font(.system(size: 24))
                    })
                    .tag(2)
                
                ProfileView()
                    .tabItem({
                        Image(systemName: "person")
                            .font(.system(size: 24))
                    })
                    .tag(3)
            }
            .edgesIgnoringSafeArea(.top)
            .accentColor(Color("Dark Blue"))
            VStack {
                Spacer()
                Button(action: {
                    self.showNewTodoView = true
                }, label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(24)
                        .background(Color("Dark Blue"))
                        .clipShape(Circle())
                })
                    .padding(.bottom, 10)
                    .shadow(radius: 10, x: 0, y: 10)
            }
        }
        .sheet(isPresented: $showNewTodoView, content: {
            NewTodoView().environment(\.managedObjectContext, self.context)
        })
    }
    
    init() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        UITabBar.appearance().backgroundColor = UIColor(named: "Pink")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
