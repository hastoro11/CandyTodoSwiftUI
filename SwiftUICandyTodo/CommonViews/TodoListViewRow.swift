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
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    var todo: Todo
    @State var refresh = false
    
    var body: some View {
        HStack(spacing: 30) {
            if todo.completed {
                CheckedView()
            } else {
                UncheckedView()
            }
            Text(todo.title + (refresh ? "" : ""))
                .font(.custom("Avenir-Book", size: 16))
                .foregroundColor(todo.completed ? Color("Light Blue") : Color("Dark Blue"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .contextMenu(menuItems: {
            Button(action: {
                self.todo.completed.toggle()
                try? self.context.save()
                self.localNotificationManager.removeCompletedNotification(id: self.todo.id.uuidString)
                self.refresh.toggle()
            }, label: {
                Image(systemName: "checkmark.circle")
                Text("Completed")
            })
            Button(action: {
                self.context.delete(self.todo)
                self.localNotificationManager.removeNotification(id: self.todo.id.uuidString, context: self.context)
                try? self.context.save()
            }, label: {
                Image(systemName: "trash")
                Text("Delete")
            })
        })
        
    }
    
    
}

//struct TodoListViewRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListViewRow(todo: TestTodo.examples[0]).previewLayout(.sizeThatFits)
//    }
//}
