//
//  SurveyStepTemplate.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct SurveyStepTemplate: Decodable {
    let template: String
    let promptType: String
    let responseType: SurveyResponseType
}
