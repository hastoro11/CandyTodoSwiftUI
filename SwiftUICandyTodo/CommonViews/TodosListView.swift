//
//  TodosListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodosListView: View {
    var todos: [Todo]
    var body: some View {
        List{
            ForEach(todos) { todo in
                TodoListViewRow(todo: todo)
            }
        }
    }
    
    init(todos: [Todo]) {
        self.todos = todos
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
}

struct TodosListView_Previews: PreviewProvider {
    static var previews: some View {
        TodosListView(todos: Todo.examples).previewLayout(.sizeThatFits)
    }
}
