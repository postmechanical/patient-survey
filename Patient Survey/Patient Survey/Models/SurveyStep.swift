//
//  SurveyStep.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation
import UIKit

struct SurveyStep {
    let prompt: SurveyPrompt
    let responseType: SurveyResponseType
    
    func makeView() -> UIView {
        UIView()
    }
}
