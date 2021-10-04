//
//  MockPatientSurveyStore.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/3/21.
//

import Foundation
import Mokka

@testable import Patient_Survey

class MockPatientSurveyStore: PatientSurveyStoreProtocol {
    let survey = ReturningFunctionMock<(UUID), Survey?>()
    let addSurveyResponse = FunctionMock<(SurveyResponse, Patient)>()
    let getSurveySummary = ReturningFunctionMock<(Patient), [Summary]?>()
    
    func survey(for patientId: UUID) -> Survey? {
        survey.recordCallAndReturn(patientId)
    }
    
    func addSurveyResponse(_ response: SurveyResponse, for patient: Patient) {
        addSurveyResponse.recordCall((response, patient))
    }
    
    func getSurveySummary(for patient: Patient) -> [Summary]? {
        getSurveySummary.recordCallAndReturn(patient)
    }
}
