//
//  TodosListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodosListView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    var todos: FetchedResults<Todo>
    var body: some View {
        List{
            ForEach(todos, id:\.self) { todo in
                TodoListViewRow(todo: todo)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let todo = self.todos[index]
                    self.context.delete(todo)
                    self.localNotificationManager.deleteNotification(title: todo.title, due: todo.due)
                    try? self.context.save()
                }
            }
        }
    }
    
    init(todos: FetchedResults<Todo>) {
        self.todos = todos
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
}

//struct TodosListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodosListView(todos: TestTodo.examples).previewLayout(.sizeThatFits)
//    }
//}
