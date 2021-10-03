//
//  ResourceBundle.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

struct ResourceBundle: Decodable {
    let resourceType: String
    let id: UUID
    let entry: [ResourceEnvelope]
}

struct ResourceEnvelope: Decodable {
    let resource: Resource
}

struct Resource: Decodable {
    let resourceType: String
    let id: UUID
    let name: [ResourceName]?
    let type: [ResourceAppointmentType]?
    let subject: ResourceReference?
    let actor: ResourceReference?
    let appointment: ResourceReference?
    let code: ResourceCodingEnvelope?
}

struct ResourceName: Decodable {
    let text: String?
    let family: String
    let given: [String]
}

struct ResourceAppointmentType: Decodable {
    let text: String
}

struct ResourceCodingEnvelope: Decodable {
    let coding: [ResourceCode]
}

struct ResourceCode: Decodable {
    let name: String
}

struct ResourceReference: Decodable {
    let reference: String
}

