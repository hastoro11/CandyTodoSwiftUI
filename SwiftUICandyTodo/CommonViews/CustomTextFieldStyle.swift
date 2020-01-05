//
//  CustomTextFieldStyle.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 05..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

public struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color("Dark Blue"), lineWidth: 0.5, antialiased: false)
                .font(.custom("Avenir-Book", size: 16))
        )
    }
}
