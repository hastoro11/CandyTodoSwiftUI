//
//  ProfileTitleView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ProfileTitleView: View {
    var title: String
    var subtitle: String = ""
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
                        if user != nil {
                            Button(action: {
                                self.showEditProfile = true
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .padding(.bottom, 3)
                            })
                        }
                    }
                    .padding(.horizontal, 30)
                    Rectangle()
                        .fill(Color("Light Blue").opacity(0.2))
                        .frame(height: 1)
                        .shadow(color: Color.black, radius: 3, x: 0, y: 3)
                }
                HStack(spacing: 20) {
                    if user != nil {
                        if getProfileImage(user!.image) != nil {
                            Image(uiImage: getProfileImage(user!.image)!)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .background(Color.red)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color("Light Blue"))
                                .clipShape(Circle())
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        Text(user == nil ? subtitle : user!.name)
                            .font(.custom("Avenir-Black", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if user != nil {
                            Text(user!.email)
                                .font(.custom("Avenir-Book", size: 16))
                        }
                    }
                    .padding(.vertical, user == nil ? 30 : 10)
                }                
                .padding(.horizontal, 30)
                
                
            }
            .foregroundColor(Color("Dark Blue"))
            

        }
    }
    
    func getProfileImage(_ image: String) -> UIImage? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let filename = url.appendingPathComponent(image)
        if let data = try? Data(contentsOf: filename), let uiImage = UIImage(data: data) {
            return uiImage
        }
        return nil
    }
}

struct ProfileTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTitleView(title: "TO-DO", subtitle: "Today's list", user: User.example, showEditProfile: Binding.constant(false) ).previewLayout(.sizeThatFits)
    }
}
