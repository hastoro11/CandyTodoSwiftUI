//
//  UserModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var email: String
    var image: String
    
    static var example: User {
        return User(name: "Tiffany Schneider", email: "tiffany.s@email.com", image: "Razewarelogo_1024.png")
    }
}
