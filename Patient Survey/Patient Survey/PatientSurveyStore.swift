//
//  PatientSurveyStore.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation
import UIKit

class PatientSurveyStore: PatientSurveyStoreProtocol {
    private let bundle: ResourceBundle
    private var responses = [UUID: [SurveyResponse]]()
    
    
    init() {
        guard let data = NSDataAsset(name: "patient-survey-data")?.data else {
            preconditionFailure("Could not load data")
        }
        let decodedBundle: ResourceBundle
        do {
            decodedBundle = try JSONDecoder().decode(ResourceBundle.self, from: data)
        } catch {
            preconditionFailure("Could not decode data: \(error)")
        }
        self.bundle = decodedBundle
    }
    
    func survey(for patientId: UUID) -> Survey? {
        guard let patient = model(of: Patient.self, with: patientId),
              let appointment = models(of: Appointment.self).first(where: { $0.patientId == patientId }),
              let diagnosis = models(of: Diagnosis.self).first(where: { $0.appointmentId == appointment.id }),
              let doctor = models(of: Doctor.self).first(where: { $0.id == appointment.doctorId }),
              let data = NSDataAsset(name: "patient-survey-steps")?.data,
              let stepTemplates = try? JSONDecoder().decode([SurveyStepTemplate].self, from: data)
        else {
            return nil
        }
        let steps = stepTemplates.compactMap({ SurveyStepBuilder(appointment: appointment, diagnosis: diagnosis, doctor: doctor, patient: patient, template: $0).makeSurveyStep() })
        guard !steps.isEmpty else {
            return nil
        }
        responses[patientId] = []
        return Survey(appointment: appointment, diagnosis: diagnosis, doctor: doctor, patient: patient, steps: steps)
    }
    
    func addSurveyResponse(_ response: SurveyResponse, for patient: Patient) {
        var patientResponses = responses[patient.id] ?? []
        patientResponses.append(response)
        responses[patient.id] = patientResponses
    }
    
    func getSurveySummary(for patient: Patient) -> [Summary]? {
        guard let patientResponses = responses[patient.id] else {
            return nil
        }
        return patientResponses.map { $0.summary }
    }
    
    func model<T: ResourceInitializable>(of type: T.Type, with id: UUID) -> T? {
        bundle.entry.compactMap { resourceEnvelope in
            guard resourceEnvelope.resource.resourceType == String(describing: type),
                  let model = type.init(from: resourceEnvelope.resource),
                  id == resourceEnvelope.resource.id
            else {
                return nil
            }
            return model
        }.first
    }
    
    func models<T: ResourceInitializable>(of type: T.Type) -> [T] {
        bundle.entry.compactMap { resourceEnvelope in
            guard resourceEnvelope.resource.resourceType == String(describing: type),
                  let model = type.init(from: resourceEnvelope.resource)
            else {
                return nil
            }
            return model
        }
    }
}
