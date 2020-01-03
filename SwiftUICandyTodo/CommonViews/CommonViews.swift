//
//  CommonViews.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct UncheckedView: View {
    var size: CGFloat = 32.0
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("Green"), lineWidth: 2)
            .frame(width: size, height: size)
    }
}

struct CheckedView: View {
    var size: CGFloat = 32.0
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Green"))
            .frame(width: size, height: size)
            .overlay(Image(systemName: "checkmark").foregroundColor(Color("Dark Blue")))
    }
}

struct InfoView: View {
    var size: CGFloat = 32.0
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Green"))
            .frame(width: size, height: size)
            .overlay(Image(systemName: "exclamationmark").foregroundColor(Color("Dark Blue")))
    }
}

struct SectionHeader: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Avenir-Book", size: 16))
                .foregroundColor(Color("Light Blue"))
                .padding()
                .offset(x: 30, y: 0)
            Spacer()
        }
        .background(Color.white)
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0))
    }
}


struct UncheckedView_Previews: PreviewProvider {
    static var previews: some View {
        CheckedView()
    }
}
