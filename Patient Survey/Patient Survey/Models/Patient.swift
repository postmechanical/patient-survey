//
//  Patient.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

@dynamicMemberLookup
struct Patient: Equatable, Identifiable, Person, ResourceInitializable {
    typealias ID = UUID
    
    let id: UUID
    let firstName: String
    let lastName: String
    
    init?(from resource: Resource) {
        id = resource.id
        guard let firstName = resource.name?.first?.given.joined(separator: " "),
              let lastName = resource.name?.first?.family else {
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
    }
    
    subscript(dynamicMember string: String) -> String? {
        switch string {
        case "id":
            return id.uuidString
        case "firstName":
            return firstName
        case "lastName":
            return lastName
        default:
            return nil
        }
    }
}
