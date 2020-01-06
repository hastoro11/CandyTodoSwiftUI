//
//  EditProfileView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 05..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var viewModel = EditProfileViewModel()
    
    var user: User?
    
    @State var showSelectPhotoView = false
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.top)
            VStack {
                VStack {
                    titleBar
                    
                    titleTextField
                }.foregroundColor(Color("Dark Blue"))
                
                ZStack {
                    Color.white
                    VStack {
                        form
                        
                        Spacer()
                        
                        button
                    }
                    
                }
                
            }
        }
        .onAppear {            
            self.viewModel.user = self.user
        }
        .sheet(isPresented: $showSelectPhotoView, content: {
            SelectPhotoView(uiImage: self.$viewModel.uiImage)
        })
        
    }
}

extension EditProfileView {
    var titleBar: some View {
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
    }
    
    var titleTextField: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                TextField("Name here...", text: $viewModel.name)
                    .font(.custom("Avenir-Black", size: 32))                
            }
            .padding(.vertical, 30)
        }
        .padding(.horizontal, 30)
    }
    
    var form: some View {
        VStack {
            Button(action: {
                self.showSelectPhotoView = true
            }, label: {
                if viewModel.uiImage == nil {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .foregroundColor(Color("Light Blue"))
                } else {
                    Image(uiImage: viewModel.uiImage!)
                        .resizable()
                        .frame(width: 128, height: 128)
                        .clipShape(Circle())
                }
                
            })
                .padding(.top, 30)
                .buttonStyle(PlainButtonStyle())
            
            Form {
                
                Text("Email")
                    .font(.custom("Avenir-Book", size: 16))
                    .foregroundColor(Color("Dark Blue"))
                
                TextField("Email here...", text: $viewModel.email)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            .padding(.horizontal, 30)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
    
    var button: some View {
        Button(action: {
            self.viewModel.saveUser(context: self.context)
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "checkmark")
                .font(.title)
                .foregroundColor(.white)
                .padding(24)
                .background(Color(viewModel.isButtonEnabled ? "Dark Blue" : "Light Blue"))
                .clipShape(Circle())
        })
            .padding(.bottom, 10)
            .shadow(radius: 10, x: 0, y: 10)
            .disabled(!viewModel.isButtonEnabled)
    }
}
