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
                        .font(.title)
                })
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(Color("Dark Blue"))
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "Pink")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
