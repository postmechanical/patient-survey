//
//  PermissionTypeTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/2/21.
//

import XCTest

@testable import Patient_Survey

class PermissionTypeTests: XCTestCase {
    func testSummary() {
        let cameraPermissionType = PermissionType.camera
        XCTAssertEqual(cameraPermissionType.summary.text, NSLocalizedString("camera & photo", comment: ""))
        
        let locationPermissionType = PermissionType.location
        XCTAssertEqual(locationPermissionType.summary.text, NSLocalizedString("location", comment: ""))
    }
}
