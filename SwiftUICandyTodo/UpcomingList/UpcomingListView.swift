//
//  UpcomingListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct UpcomingListView: View {
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)], predicate: Utils.upcomingPredicate()) var todos: FetchedResults<Todo>
    
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "SCHEDULER", subtitle: "Upcoming tasks")
                    
                    List {
                        ForEach(Utils.upcomingTodos(todos), id:\.date) {dailyTodo in
                            Section(header: SectionHeader(title: dailyTodo.date)) {
                                ForEach(dailyTodo.todos, id:\.self) {todo in
                                    TodoListViewRow(todo: todo)
                                }
                            }
                            .background(Color.white)
                        }
                    }
                }
            }
        }
    }
    
}


struct UpcomingListView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingListView()
    }
}
