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
    
    var summary: Summary {
        switch self {
        case .camera:
            return Summary(text: NSLocalizedString("camera & photo", comment: ""), commentary: nil)
        case .location:
            return Summary(text: NSLocalizedString("location", comment: ""), commentary: nil)
        }
    }
}
