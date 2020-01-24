//
//  SplasView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 24..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct SplasView: View {
    var body: some View {
        ZStack {
            Color("Pink")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("LaunchIcon")
                Text("CANDY TODO")
                    .foregroundColor(Color("Dark Blue"))
                    .font(.custom("Avenir-Black", size: 20))
                    .kerning(10)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
            }
            .offset(.init(width: 0, height: -48))            
        }
    }
}

struct SplasView_Previews: PreviewProvider {
    static var previews: some View {
        SplasView()
    }
}
