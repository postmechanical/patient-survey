//
//  PermissionType.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

enum PermissionType: Summarizable {
    case camera
    case location
    
    var summary: String {
        switch self {
        case .camera:
            return NSLocalizedString("camera & photo", comment: "")
        case .location:
            return NSLocalizedString("location", comment: "")
        }
    }
}
