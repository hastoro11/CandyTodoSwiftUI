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
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "due", ascending: true)], predicate: Utils.todayPredicate()) var todos: FetchedResults<Todo>
    @State var refresh = false {
        didSet {
            print(refresh)
        }
    }
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            ZStack {
                
                Color.white
                
                VStack {
                    TitleView(title: "TO-DO", subtitle: "Today's list")
                    TodosListView(todos: todos)
                }
            }
            
        }
    }
    
    func complete(_ todo: Todo) {
        todo.completed.toggle()
        try? context.save()        
        self.refresh.toggle()
    }
}

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListView()
    }
}
