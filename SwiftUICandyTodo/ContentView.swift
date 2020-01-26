//
//  ContentView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {    
    @State var showNewTodoView = false
    @State var showSplash = true
    @State var isUnlocked = false
    @State var noBiometry = false
    
    var body: some View {
        
        ZStack {
            if self.isUnlocked {
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
                    NewTodoView()
                })
                SplasView()
                    .opacity(showSplash ? 1 : 0)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                self.showSplash = false
                            }
                        })
                }
            } else {
                SplasView()
                    .alert(isPresented: $noBiometry, content: {
                        Alert(title: Text("No biometry"), message: Text("Your device is not configured for biometric authentication."), dismissButton: .default(Text("OK"), action: {self.isUnlocked = true}))
                    })
            }
        }.onAppear {
            self.authenticat()
        }
    }
    
    func authenticat() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "This app needs to unlock your phone"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                DispatchQueue.main.async {
                    self.isUnlocked = success
                }                
            }
        } else {
            self.noBiometry = true
        }
    }
    
    init() {
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        UITabBar.appearance().backgroundColor = UIColor(named: "Pink")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
