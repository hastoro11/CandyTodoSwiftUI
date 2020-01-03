//
//  ContentView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
