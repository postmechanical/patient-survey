//
//  SurveyResponseTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/2/21.
//

import XCTest

@testable import Patient_Survey

class SurveyResponseTests: XCTestCase {
    func testSummary() {
        let yesResponse = SurveyResponse.bool(true)
        XCTAssertEqual(yesResponse.summary.text, NSLocalizedString("Yes", comment: ""))
        
        let noResponse = SurveyResponse.bool(false)
        XCTAssertEqual(noResponse.summary.text, NSLocalizedString("No", comment: ""))
        
        let scaleResponse = SurveyResponse.scale(1...10, 3)
        XCTAssertEqual(scaleResponse.summary.text, String(format: NSLocalizedString("%i on scale of %i-%i", comment: ""), 3, 1, 10))
        
        let text = "All good"
        let textResponse = SurveyResponse.text(text)
        XCTAssertEqual(textResponse.summary.text, text)
        
        let grantedCameraPermissionsResponse = SurveyResponse.permission(true, .camera, UIImage())
        XCTAssertEqual(grantedCameraPermissionsResponse.summary.text, String(format: NSLocalizedString("Granted %@ permissions", comment: ""), PermissionType.camera.summary.text))

        let deniedCameraPermissionsResponse = SurveyResponse.permission(false, .camera, nil)
        XCTAssertEqual(deniedCameraPermissionsResponse.summary.text, String(format: NSLocalizedString("Denied %@ permissions", comment: ""), PermissionType.camera.summary.text))
    }
}
