//
//  Patient.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct Patient: Identifiable, Person {
    typealias ID = UUID
    
    let id: UUID
    let firstName: String
    let lastName: String
}
