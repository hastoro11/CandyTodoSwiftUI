//
//  TodayListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodayListView: View {    
    @ObservedObject var viewModel = TodoListViewModel()
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)], predicate: TodoListViewModel.todayPredicate) var todos: FetchedResults<Todo>
    
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            ZStack {
                
                Color.white
                
                VStack {
                    TitleView(title: "TO-DO", subtitle: "Today's list")
                    List{
                        ForEach(todos, id:\.id) { todo in
                            TodoListViewRow(todo: todo, toggleCompleted: self.toggleCompleted, delete: self.delete)
                        }
                        .onDelete(perform: {indexSet in
                            for index in indexSet {
                                let todo = self.todos[index]
                                self.delete(todo)
                            }
                        })
                    }
                }
            }
            
        }.onAppear {
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
        }
    }
    
    func toggleCompleted(_ todo: Todo) {
        viewModel.toggleCompleted(todo)
    }
    
    func delete(_ todo: Todo) {
        viewModel.delete(todo)        
    }
}
