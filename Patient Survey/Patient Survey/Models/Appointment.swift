//
//  Appointment.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

@dynamicMemberLookup
struct Appointment: Equatable, Identifiable, ResourceInitializable {
    typealias ID = UUID

    let id: UUID
    let type: String
    let doctorId: UUID
    let patientId: UUID
    
    init?(from resource: Resource) {
        id = resource.id
        guard let type = resource.type?.map({ $0.text }).joined(separator: ", "),
        let actorReference = resource.actor?.reference,
        let doctorId = UUID(uuidString: actorReference.replacingOccurrences(of: "\(String(describing: Doctor.self))/", with: "")),
        let subjectReference = resource.subject?.reference,
        let patientId = UUID(uuidString: subjectReference.replacingOccurrences(of: "\(String(describing: Patient.self))/", with: ""))
        else {
            return nil
        }
        self.type = type
        self.doctorId = doctorId
        self.patientId = patientId
    }
    
    subscript(dynamicMember string: String) -> String? {
        switch string {
        case "id":
            return id.uuidString
        case "type":
            return type
        case "doctorId":
            return doctorId.uuidString
        case "patientId":
            return patientId.uuidString
        default:
            return nil
        }
    }
}
