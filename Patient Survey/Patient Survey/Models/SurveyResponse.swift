//
//  SurveyResponse.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

enum SurveyResponse: Summarizable {
    case bool(Bool)
    case scale(ClosedRange<Int>, Int)
    case text(String)
    case permission(Bool, PermissionType, Any?)
    
    var summary: String {
        switch self {
        case .bool(let bool):
            return bool ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: "")
        case .scale(let closedRange, let value):
            return String(format: NSLocalizedString("%i on scale of %i to %i", comment: ""), value, closedRange.lowerBound, closedRange.upperBound)
        case .text(let string):
            return string
        case .permission(let bool, let permissionType, _):
            return String(format: bool ? NSLocalizedString("Granted %@ permissions", comment: "") : NSLocalizedString("Denied %@ permissions", comment: ""), permissionType.summary)
        }
    }
}
