//
//  EditProfileNew.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 05..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct EditProfileNew: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name = ""
    @State var email = ""
    var body: some View {
        ZStack(alignment: .top) {
            Color("Pink")
                .frame(height: 240)
                .edgesIgnoringSafeArea(.top)
            
            VStack {
                VStack {
                    VStack(spacing: 0) {
                        Text("EDIT PROFILE")
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
                            TextField("Full name...", text: $name)
                                .font(.custom("Avenir-Black", size: 32))
                        }
                        .padding(.vertical, 30)
                    }
                    .padding(.horizontal, 30)
                }
                .foregroundColor(Color("Dark Blue"))
//                .frame(maxHeight: 400)
                
                Button(action: {}, label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .foregroundColor(Color("Light Blue"))
                })
                    .padding(.top, 90)
                Form {
                    
                    Text("Email")
                        .font(.custom("Avenir-Book", size: 16))
                        .foregroundColor(Color("Dark Blue"))
                    
                    TextField("Email here...", text: $email)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                .padding(.horizontal, 30)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
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
}

struct EditProfileNew_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileNew()
    }
}
