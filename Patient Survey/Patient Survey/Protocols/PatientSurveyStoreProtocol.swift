//
//  PatientSurveyStoreProtocol.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

protocol PatientSurveyStoreProtocol {
    func survey(for patientId: UUID) -> Survey?
    func addSurveyResponse(_ response: SurveyResponse, for patient: Patient)
    func getSurveySummary(for patient: Patient) -> [String]?
}
