//
//  TodoListViewRow.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodoListViewRow: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var todoViewListModel = TodoListViewModel()
    var localNotificationManager = LocalNotificationManager()
    var todo: Todo
    var currentTodo: Todo {
        context.object(with: todo.objectID) as! Todo
    }
    @State var refreshing = false
    var body: some View {
        HStack(spacing: 30) {
            if todo.completed {
                CheckedView()
            } else {
                UncheckedView()
            }
            Text(todo.title + (refreshing ? "" : ""))
                .font(.custom("Avenir-Book", size: 16))
                .foregroundColor(todo.completed ? Color("Light Blue") : Color("Dark Blue"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .contextMenu(menuItems: {
            Button(action: complete, label: {
                Image(systemName: "checkmark.circle")
                Text("Completed")
            })
            Button(action: delete, label: {
                Image(systemName: "trash")
                Text("Delete")
            })
        })
        
    }
    
    func complete() {
        todoViewListModel.toggleCompleted(todo)
        refreshing.toggle()
    }
    
    func delete() {
        todoViewListModel.delete(todo)
        refreshing.toggle()
    }
    
}
