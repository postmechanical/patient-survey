//
//  Diagnosis.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct Diagnosis: Identifiable {
    typealias ID = UUID
    
    let id: UUID
    let name: String
}
