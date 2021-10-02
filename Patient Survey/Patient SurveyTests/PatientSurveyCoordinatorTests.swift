//
//  PatientSurveyCoordinatorTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/1/21.
//

import XCTest
@testable import Patient_Survey

class PatientSurveyCoordinatorTests: XCTestCase {
    var patientSurveyCoordinator: PatientSurveyCoordinator!
    var navigationController: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        patientSurveyCoordinator = PatientSurveyCoordinator(navigationController)
    }
    
    func testWhenStartExpectNavigationControllerToPush() {
        patientSurveyCoordinator.start()
        XCTAssertTrue(navigationController.pushViewController.argument?.viewController is ViewController)
        XCTAssertFalse(navigationController.pushViewController.argument?.animated ?? true)
    }
}
