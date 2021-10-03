//
//  Diagnosis.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

@dynamicMemberLookup
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
    
    subscript(dynamicMember string: String) -> String? {
        switch string {
        case "id":
            return id.uuidString
        case "name":
            return name
        case "appointmentId":
            return appointmentId.uuidString
        default:
            return nil
        }
    }
}
