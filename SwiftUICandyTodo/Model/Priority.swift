//
//  Priority.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 06..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high = 0, medium, low
    
    var description: String {
        switch self {
        case .high:
            return "High"
        case .medium:
            return "Normal"
        case .low:
            return "Low"
        }
    }
}
