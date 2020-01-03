//
//  TitleView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var subtitle: String
    var email: String?
    var image: String?
    var body: some View {
        ZStack(alignment: .top) {
            Color("Pink")
                .frame(height: 240)
                .edgesIgnoringSafeArea(.top)
            
            VStack {
                VStack(spacing: 0) {
                    Text(title)
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
                    if image != nil {
                        Image(uiImage: getProfileImage(image!))
                            .resizable()
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                        .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        Text(subtitle)
                            .font(.custom("Avenir-Black", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if email != nil {
                            Text(email!)
                                .font(.custom("Avenir-Book", size: 16))
                        }
                    }
                    .padding(.vertical, email == nil ? 30 : 10)
                }                
                .padding(.horizontal, 30)
                
                
            }
            .foregroundColor(Color("Dark Blue"))
            

        }
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

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "TO-DO", subtitle: "Today's list", email: "email@email.com", image: "Razewarelogo_1024.png").previewLayout(.sizeThatFits)
    }
}
