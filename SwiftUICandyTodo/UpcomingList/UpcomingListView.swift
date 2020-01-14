//
//  UpcomingListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import CoreData

struct UpcomingListView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var viewModel = TodoListViewModel()
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)], predicate: TodoListViewModel.upcomingPredicate) var todos: FetchedResults<Todo>
    
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            ZStack {
                Color.white
                VStack {
                    TitleView(title: "SCHEDULER", subtitle: "Upcoming tasks")
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.createUpcomingTodos(todos), id:\.date) { dailyTodo in
                                VStack {
                                    SectionHeader(title: dailyTodo.date)
                                    ForEach(dailyTodo.todos, id:\.objectID) {todo in
                                       TodoListViewRow(todo: todo)
                                        .padding(.horizontal, 15)
                                    }
                                }
                            }
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
