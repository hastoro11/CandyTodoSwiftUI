//
//  TodoListViewRow.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodoListViewRow: View {
    var todo: Todo
    var body: some View {
        HStack(spacing: 30) {
            if todo.completed {
                CheckedView()
            } else {
                UncheckedView()
            }
            Text(todo.title)
                .font(.custom("Avenir-Book", size: 16))
                .foregroundColor(todo.completed ? Color("Light Blue") : Color("Dark Blue"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

struct TodoListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoListViewRow(todo: Todo.examples[0]).previewLayout(.sizeThatFits)
    }
}
