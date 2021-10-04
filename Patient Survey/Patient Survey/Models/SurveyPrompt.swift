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
    
    var summary: Summary {
        switch self {
        case .text(let string):
            return Summary(text: string, commentary: nil)
        case .permission(let permissionType):
            return Summary(text: String(format: NSLocalizedString("Please grant %@ access to submit response.", comment: ""), permissionType.summary.text), commentary: nil)
        }
    }
}
