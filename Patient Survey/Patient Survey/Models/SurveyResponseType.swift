//
//  SurveyResponseType.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

enum SurveyResponseType: String, Decodable {
    case bool
    case permission
    case scale
    case text
}
