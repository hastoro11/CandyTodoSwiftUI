//
//  NewTodoView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct NewTodoView: View {
    @State var title = ""
    var body: some View {
        ZStack(alignment: .top) {
            Color("Pink")
                .frame(height: 240)
                .edgesIgnoringSafeArea(.top)
            
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
                
                Spacer()
                
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

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView()
    }
}
