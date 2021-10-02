//
//  Appointment.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct Appointment: Identifiable {
    typealias ID = UUID

    let id: UUID
    let type: String
    let doctor: Doctor
    let patient: Patient
}
