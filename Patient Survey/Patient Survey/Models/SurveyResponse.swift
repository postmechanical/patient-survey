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
    
    var summary: Summary {
        let happyCommentary = NSLocalizedString("We're happy to hear you're satisfied 😅", comment: "")
        let unhappyCommentary = NSLocalizedString("We're sorry to hear you're not satisfied 😢", comment: "")
        switch self {
        case .bool(let bool):
            return Summary(
                text: bool ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: ""),
                commentary: bool ? happyCommentary : unhappyCommentary
            )
        case .scale(let closedRange, let value):
            return Summary(
                text: String(format: NSLocalizedString("%i on scale of %i-%i", comment: ""), value, closedRange.lowerBound, closedRange.upperBound),
                commentary: value <= (closedRange.upperBound / 2) ? unhappyCommentary : happyCommentary
            )
        case .text(let string):
            // TODO: Use CoreML for on device sentiment analysis of free text
            let s = string.lowercased()
            let commentary: String?
            if s.starts(with: "no") {
                commentary = unhappyCommentary
            } else if s.starts(with: "yes") {
                commentary = happyCommentary
            } else {
                commentary = nil
            }
            return Summary(
                text: string,
                commentary: commentary
            )
        case .permission(let bool, let permissionType, _):
            return Summary(
                text: String(format: bool ? NSLocalizedString("Granted %@ permissions", comment: "") : NSLocalizedString("Denied %@ permissions", comment: ""), permissionType.summary.text),
                commentary: nil
            )
        }
    }
}
