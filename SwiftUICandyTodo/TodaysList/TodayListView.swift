//
//  TodayListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TodayListView: View {
    var todos = Todo.examples
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            VStack {
                TitleView(title: "TO-DO", subtitle: "Today's list")
                TodosListView(todos: todaysTodos())                
            }
        }
    }
    
    func todaysTodos() -> [Todo] {
        return todos.filter({Calendar.current.isDateInToday($0.due)})      
    }
}

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListView()
    }
}
