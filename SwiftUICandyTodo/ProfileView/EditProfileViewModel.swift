//
//  EditProfileViewModel.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 05..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class EditProfileViewModel: ObservableObject {

    var user: User? {
        didSet {
            if let user = user {
                self.name = user.name
                self.email = user.email
                self.uiImage = user.uiImage
            }
        }
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var uiImage: UIImage?
    
    
    var isButtonEnabled: Bool {
        return !self.name.isEmpty && !self.email.isEmpty
    }
    
    func saveUser(context: NSManagedObjectContext) {
        if user == nil {
            let newUser = User(context: context)
            newUser.name = name
            newUser.email = email
            guard let data = uiImage?.jpegData(compressionQuality: 0.5) else {return}
            newUser.image = data
        } else {
            user!.name = name
            user!.email = email
            guard let data = uiImage?.jpegData(compressionQuality: 0.5) else {return}
            user!.image = data
        }
        try? context.save()
    }
}
