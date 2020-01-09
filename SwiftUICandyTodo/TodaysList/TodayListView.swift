//
//  TodayListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodayListView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var todoManager: TodoManager
    
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            ZStack {
                
                Color.white
                
                VStack {
                    TitleView(title: "TO-DO", subtitle: "Today's list")
                    List{
                        ForEach(todoManager.todos, id:\.id) { todo in
                            TodoListViewRow(todo: todo)
                        }                        
                    }
                }
            }
            
        }.onAppear {
            self.todoManager.todaysTodos()
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
        }
    }
}
