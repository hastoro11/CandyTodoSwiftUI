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
        VStack {
            ZStack(alignment: .top) {
                Color("Pink")
                    .frame(height: 240)
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    VStack(spacing: 0) {
                        Text("TO-DO")
                            .font(.custom("Avenir-Black", size: 20))
                            .kerning(10)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                        
                        Rectangle()
                            .fill(Color("Light Blue").opacity(0.2))
                            .frame(height: 1)
                            .shadow(color: Color.black, radius: 3, x: 0, y: 3)
                    }
                    
                    Text("Today's list")
                        .font(.custom("Avenir-Black", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 30)
                        .padding(.horizontal, 30)
                }
                .foregroundColor(Color("Dark Blue"))
                

            }
            List{
                ForEach(todos) { todo in
                    HStack(spacing: 30) {
                        if todo.completed {
                            CheckedView()
                        } else {
                            UncheckedView()
                        }
                        Text(todo.title)
                            .font(.custom("Avenir-Book", size: 16))
                            .foregroundColor(Color("Dark Blue"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                }
            }
            .padding(.top, -30)
            Spacer()
        }
//        ZStack {
//            Color("Pink")
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                VStack {
//                    VStack(spacing: 0) {
//                        Text("TO-DO")
//                            .font(.custom("Avenir-Black", size: 20))
//                            .kerning(10)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 20)
//
//                        Rectangle()
//                            .fill(Color("Light Blue").opacity(0.2))
//                            .frame(height: 1)
//                            .shadow(color: Color.black, radius: 3, x: 0, y: 3)
//                    }
//
//                    Text("Today's List")
//                        .font(.custom("Avenir-Black", size: 32))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical, 30)
//                        .padding(.horizontal)
//                }
//                .foregroundColor(Color("Dark Blue"))
//
//                List{
//                    ForEach(todos) { todo in
//                        HStack(spacing: 30) {
//                            if todo.completed {
//                                CheckedView()
//                            } else {
//                                UncheckedView()
//                            }
//                            Text(todo.title)
//                                .font(.custom("Avenir-Book", size: 16))
//                                .foregroundColor(Color("Dark Blue"))
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 30)
//                        .padding(.vertical, 10)
//                    }
//                }
//
//                Spacer()
//            }
//            Spacer()
//        }
    }
    
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
}

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListView()
    }
}
