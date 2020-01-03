//
//  NewTodoView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct NewTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var due: Date = Date()
    @State var priority = 0
    @State var notifyAbout = false
    @State var insertIntoCalendaer = true
    var body: some View {
        ZStack(alignment: .top) {
            Color("Pink")
                .frame(height: 240)
                .edgesIgnoringSafeArea(.top)
            
            VStack {
                VStack {
                    VStack(spacing: 0) {
                        Text("NEW TASK")
                            .font(.custom("Avenir-Black", size: 20))
                            .kerning(10)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                        
                        Rectangle()
                            .fill(Color("Light Blue").opacity(0.2))
                            .frame(height: 1)
                            .shadow(color: Color.black, radius: 3, x: 0, y: 3)
                    }
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            TextField("Write here...", text: $title)
                                .font(.custom("Avenir-Black", size: 32))
                        }
                        .padding(.vertical, 30)
                    }
                    .padding(.horizontal, 30)
                }
                .foregroundColor(Color("Dark Blue"))
                VStack {
                    Form {
                        Section {
                            DatePicker(selection: $due, displayedComponents: [.date, .hourAndMinute], label: {
                                Text("Complete by:")
                                     .padding(.horizontal, 30)
                            })
                                .padding(.trailing, 30)
                        }
                        
                        Section {
                            Text("Priority")
                             .padding(.horizontal, 30)
                            Picker(selection: $priority, label: Text("Priority"), content: {
                                Text("High").tag(0)
                                Text("Normal").tag(1)
                                Text("Low").tag(2)
                                }).pickerStyle(SegmentedPickerStyle())
                             .padding(.horizontal, 30)
                        }
                        
                        Section(header: SectionHeader(title: "More Options"), content: {
                            HStack {
                                Text("Notify about this")
                                    .foregroundColor(Color("Dark Blue"))
                                    .font(.custom("Avenir-Book", size: 16))
                                Toggle(isOn: $notifyAbout, label: {
                                    Text("")
                                })
                            } .padding(.horizontal, 30)
                            HStack {
                                Text("Insert into calendar")
                                    .foregroundColor(Color("Dark Blue"))
                                    .font(.custom("Avenir-Book", size: 16))
                                Toggle(isOn: $insertIntoCalendaer, label: {
                                    Text("")
                                })
                            } .padding(.horizontal, 30)
                        })
//
                    }
                    .font(.custom("Avenir-Book", size: 16))
                    .foregroundColor(Color("Dark Blue"))
                    .padding(.top, 30)
                }
                
                
                                
                
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(24)
                        .background(Color("Dark Blue"))
                        .clipShape(Circle())
                })
                    .padding(.bottom, 10)
                    .shadow(radius: 10, x: 0, y: 10)
            }
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    func getProfileImage(_ image: String) -> UIImage {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return UIImage()}
        let filename = url.appendingPathComponent(image)
        if let data = try? Data(contentsOf: filename), let uiImage = UIImage(data: data) {
            return uiImage
        }
        return UIImage()
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView()
    }
}
