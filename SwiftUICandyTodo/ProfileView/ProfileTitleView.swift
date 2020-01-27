//
//  ProfileTitleView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ProfileTitleView: View {
    var title: LocalizedStringKey
    var user: User?
    @Binding var showEditProfile: Bool
    var body: some View {
        ZStack(alignment: .top) {
            Color("Pink")
                .frame(height: 240)
                .edgesIgnoringSafeArea(.top)
            
            VStack {
                VStack(spacing: 0) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(title)
                            .font(.custom("Avenir-Black", size: 20))
                            .kerning(10)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                        
                        Button(action: {
                            self.showEditProfile = true
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .padding(.bottom, 3)
                        })
                    }
                    .padding(.horizontal, 30)
                    Rectangle()
                        .fill(Color("Light Blue").opacity(0.2))
                        .frame(height: 1)
                        .shadow(color: Color.black, radius: 3, x: 0, y: 3)
                }
                HStack(spacing: 20) {
                    if user != nil {
                        ProfileImage
                    } else {
                        BlankUserProfileImage
                    }

                    VStack(alignment: .leading) {
                        Text(user?.name ?? "Name here...")
                            .font(.custom("Avenir-Black", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                                                
                        Text(user?.email ?? "Email here...")
                            .font(.custom("Avenir-Book", size: 16))
                        
                    }
                    .padding(.vertical, user == nil ? 30 : 10)
                }
                .padding(.horizontal, 30)

                
            }
            .foregroundColor(Color("Dark Blue"))
            

        }
    }
}

extension ProfileTitleView {
    
    var ProfileImage: some View {
        Image(uiImage: user!.uiImage!)
            .resizable()
            .frame(width: 60, height: 60)
            .background(Color.red)
            .clipShape(Circle())
    }
    
    var BlankUserProfileImage: some View {
        Image(systemName: "person.circle")
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundColor(Color("Light Blue"))
            .clipShape(Circle())
    }
}
