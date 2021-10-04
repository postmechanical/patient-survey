//
//  SurveyPromptTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/2/21.
//

import XCTest

@testable import Patient_Survey

class SurveyPromptTests: XCTestCase {
    func testSummary() {
        let text = "Sup?"
        let textPrompt = SurveyPrompt.text(text)
        XCTAssertEqual(textPrompt.summary.text, text)
        
        let cameraPermissionPrompt = SurveyPrompt.permission(.camera)
        XCTAssertEqual(cameraPermissionPrompt.summary.text, String(format: NSLocalizedString("Please grant %@ access to submit response.", comment: ""), PermissionType.camera.summary.text))
        
        let locationPermissionPrompt = SurveyPrompt.permission(.location)
        XCTAssertEqual(locationPermissionPrompt.summary.text, String(format: NSLocalizedString("Please grant %@ access to submit response.", comment: ""), PermissionType.location.summary.text))
    }
}
