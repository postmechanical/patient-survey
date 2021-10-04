//
//  Survey+Mock.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/3/21.
//

import Foundation

@testable import Patient_Survey

extension Survey {
    static func mock() -> Survey {
        let patientId = UUID()
        let doctorId = UUID()
        let appointment = Appointment(from: Resource(
            resourceType: "Appointment",
            id: UUID(),
            name: nil,
            type: [ResourceAppointmentType(text: "Hangnail")],
            subject: ResourceReference(reference: "Patient/\(patientId.uuidString)"),
            actor: ResourceReference(reference: "Doctor/\(doctorId.uuidString)"),
            appointment: nil,
            code: nil
        ))!
        let diagnosis = Diagnosis(from: Resource(
            resourceType: "Diagnosis",
            id: UUID(),
            name: nil,
            type: nil,
            subject: nil,
            actor: nil,
            appointment: ResourceReference(reference: "Appointment/\(appointment.id.uuidString)"),
            code: ResourceCodingEnvelope(coding: [ResourceCode(name: "Inoperable chronic nasty foot")])))!
        let doctor = Doctor(from: Resource(
            resourceType: "Doctor",
            id: doctorId,
            name: [ResourceName(
                text: nil,
                family: "Strangelove",
                given: ["Doctor"]
            )],
            type: nil,
            subject: nil,
            actor: nil,
            appointment: nil,
            code: nil))!
        let patient = Patient(from: Resource(
            resourceType: "Patient",
            id: patientId,
            name: [ResourceName(
                text: nil,
                family: "Testerson",
                given: ["Testy"]
            )],
            type: nil,
            subject: nil,
            actor: nil,
            appointment: nil,
            code: nil))!
        return Survey(
            appointment: appointment,
            diagnosis: diagnosis,
            doctor: doctor,
            patient: patient,
            steps: [
                SurveyStep(
                    prompt: .text("Did Dr {doctor.lastName} clearly explain the importance of unit testing to you?"),
                    responseType: .bool
                ),
                SurveyStep(
                    prompt: .text("On scale of 1-10, how do you feel about unit testing?"),
                    responseType: .scale(1...10)
                )
            ])
    }
}
