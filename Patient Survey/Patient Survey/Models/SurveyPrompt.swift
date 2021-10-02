//
//  SurveyPrompt.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

enum SurveyPrompt: Summarizable {
    case text(String)
    case permission(PermissionType)
    
    var summary: String {
        switch self {
        case .text(let string):
            return string
        case .permission(let permissionType):
            return String(format: NSLocalizedString("Please grant %@ access to submit.", comment: ""), permissionType.summary)
        }
    }
}
