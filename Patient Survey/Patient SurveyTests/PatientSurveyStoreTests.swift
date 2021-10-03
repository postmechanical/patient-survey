//
//  PatientSurveyStoreTests.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/2/21.
//

import XCTest

@testable import Patient_Survey

class PatientSurveyStoreTests: XCTestCase {
    var store: PatientSurveyStore!
    
    override func setUp() {
        super.setUp()
        store = PatientSurveyStore()
    }
    
    func testModelOfPatientWithIdWhenPatientWithIdDoesNotExist() {
        let patient = store.model(of: Patient.self, with: UUID())
        XCTAssertNil(patient)
    }
    
    func testModelOfPatientWithIdWhenPatientWithIdExists() throws {
        let patient = store.model(of: Patient.self, with: try XCTUnwrap(UUID(uuidString: "6739ec3e-93bd-11eb-a8b3-0242ac130003")))
        XCTAssertEqual(patient?.firstName, "Tendo")
        XCTAssertEqual(patient?.lastName, "Tenderson")
    }
    
    func testSurveyForPatientIdWhenPatientWithIdDoesNotExist() {
        let survey = store.survey(for: UUID())
        XCTAssertNil(survey)
    }
    
    func testSurveyForPatientIdWhenPatientWithIdExists() throws {
        let patientId = try XCTUnwrap(UUID(uuidString: "6739ec3e-93bd-11eb-a8b3-0242ac130003"))
        let survey = store.survey(for: patientId)
        XCTAssertEqual(survey?.patient, store.model(of: Patient.self, with: patientId))
        XCTAssertEqual(survey?.doctor, store.model(of: Doctor.self, with: try XCTUnwrap(UUID(uuidString: "9bf9e532-93bd-11eb-a8b3-0242ac130003"))))
        XCTAssertEqual(survey?.diagnosis, store.model(of: Diagnosis.self, with: try XCTUnwrap(UUID(uuidString: "541a72a8-df75-4484-ac89-ac4923f03b81"))))
        XCTAssertEqual(survey?.appointment, store.model(of: Appointment.self, with: try XCTUnwrap(UUID(uuidString: "be142dc6-93bd-11eb-a8b3-0242ac130003"))))
        survey?.steps.forEach { step in
            XCTAssertFalse(step.prompt.summary.contains("{"))
        }
    }
}
