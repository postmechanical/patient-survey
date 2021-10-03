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
        XCTAssertEqual(yesResponse.summary, NSLocalizedString("Yes", comment: ""))
        
        let noResponse = SurveyResponse.bool(false)
        XCTAssertEqual(noResponse.summary, NSLocalizedString("No", comment: ""))
        
        let scaleResponse = SurveyResponse.scale(1...10, 3)
        XCTAssertEqual(scaleResponse.summary, String(format: NSLocalizedString("%i on scale of %i to %i", comment: ""), 3, 1, 10))
        
        let text = "All good"
        let textResponse = SurveyResponse.text(text)
        XCTAssertEqual(textResponse.summary, text)
        
        let grantedCameraPermissionsResponse = SurveyResponse.permission(true, .camera, UIImage())
        XCTAssertEqual(grantedCameraPermissionsResponse.summary, String(format: NSLocalizedString("Granted %@ permissions", comment: ""), PermissionType.camera.summary))

        let deniedCameraPermissionsResponse = SurveyResponse.permission(false, .camera, nil)
        XCTAssertEqual(deniedCameraPermissionsResponse.summary, String(format: NSLocalizedString("Denied %@ permissions", comment: ""), PermissionType.camera.summary))
    }
}
