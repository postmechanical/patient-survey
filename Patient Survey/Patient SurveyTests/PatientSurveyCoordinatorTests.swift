//
//  PatientSurveyCoordinatorTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/1/21.
//

import XCTest
@testable import Patient_Survey
import PhotosUI

class PatientSurveyCoordinatorTests: XCTestCase {
    var patientSurveyCoordinator: PatientSurveyCoordinator!
    var navigationController: MockNavigationController!
    var patientSurveyStore: MockPatientSurveyStore!
    
    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        patientSurveyStore = MockPatientSurveyStore()
        patientSurveyStore.survey.defaultReturnValue = Survey.mock()
        patientSurveyStore.getSurveySummary.defaultReturnValue = []
        patientSurveyCoordinator = PatientSurveyCoordinator(
            navigationController: navigationController,
            patientSurveyStore: patientSurveyStore
        )
    }
    
    func testWhenStartExpectToGetSurveyFromPatientSurveyStoreAndNavigationControllerToPushSurveyStepViewController() {
        patientSurveyCoordinator.start()
        XCTAssertTrue(navigationController.setViewControllers.argument?.viewControllers.first is SurveyStepViewController)
        XCTAssertTrue(navigationController.setViewControllers.argument?.animated ?? false)
    }
    
    func testWhenNextExpectPatientSurveyStoreToGetNextStepAddCurrentResponseAndNavigationControllerToPushNextSurveyStepViewController() {
        patientSurveyCoordinator.start()
        patientSurveyCoordinator.next(add: nil)
        XCTAssertTrue(navigationController.pushViewController.argument?.viewController is SurveyStepViewController)
        XCTAssertTrue(navigationController.setViewControllers.argument?.animated ?? false)
    }

    func testWhenNextOnLastStepExpectPatientSurveyStoreToAddCurrentResponseAndNavigationControllerToSetViewControllersToSurveySummaryViewController() {
        patientSurveyCoordinator.start()
        patientSurveyCoordinator.next(add: nil)
        patientSurveyCoordinator.next(add: nil)
        XCTAssertTrue(navigationController.setViewControllers.argument?.viewControllers.first is SurveySummaryViewController)
        XCTAssertTrue(navigationController.setViewControllers.argument?.animated ?? false)
    }
    
    func testWhenFinishExpectNavigationControllerToSetViewControllersToSurveySummaryViewController() {
        patientSurveyCoordinator.start()
        patientSurveyCoordinator.finish()
        XCTAssertTrue(navigationController.setViewControllers.argument?.viewControllers.first is SurveySummaryViewController)
        XCTAssertTrue(navigationController.setViewControllers.argument?.animated ?? false)
    }
    
    func testWhenPromptForPermissionTypeWithCameraExpectNavigationControllerToPresentPhotoPicker() {
        patientSurveyCoordinator.promptFor(permission: .camera, completion: nil)
        XCTAssertTrue(navigationController.present.argument?.viewControllerToPresent is PHPickerViewController)
        XCTAssertTrue(navigationController.present.argument?.animated ?? false)
    }
}
