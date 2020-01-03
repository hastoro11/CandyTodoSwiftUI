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
                
                Text(subtitle)
                    .font(.custom("Avenir-Black", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 30)
            }
            .foregroundColor(Color("Dark Blue"))
            

        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "TO-DO", subtitle: "Today's list").previewLayout(.sizeThatFits)
    }
}
