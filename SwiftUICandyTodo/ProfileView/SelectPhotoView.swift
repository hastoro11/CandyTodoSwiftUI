//
//  SelectPhotoView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 05..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct SelectPhotoView: UIViewControllerRepresentable {
    @Binding var uiImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
 
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: SelectPhotoView
        
        init(_ parent: SelectPhotoView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.uiImage = image
            } else if let image = info[.originalImage] as? UIImage {
                parent.uiImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> SelectPhotoView.Coordinator {
        Coordinator(self)
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
}
