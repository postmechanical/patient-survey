//
//  Survey.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct Survey {
    let appointment: Appointment
    let diagnosis: Diagnosis
    let doctor: Doctor
    let patient: Patient
    let steps: [SurveyStep]
}
