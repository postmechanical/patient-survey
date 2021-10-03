//
//  Diagnosis.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct Diagnosis: Equatable, Identifiable, ResourceInitializable {
    typealias ID = UUID
    
    let id: UUID
    let name: String
    let appointmentId: UUID
    
    init?(from resource: Resource) {
        id = resource.id
        guard let name = resource.code?.coding.map({ $0.name }).joined(separator: ", "),
              let appointmentReference = resource.appointment?.reference,
              let appointmentId = UUID(uuidString: appointmentReference.replacingOccurrences(of: "\(String(describing: Appointment.self))/", with: ""))
        else {
            return nil
        }
        self.name = name
        self.appointmentId = appointmentId
    }
}
