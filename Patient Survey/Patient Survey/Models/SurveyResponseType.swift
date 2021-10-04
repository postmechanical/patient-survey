//
//  SurveyResponseType.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

// TODO: add support for validation of free text

enum SurveyResponseType: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }

    case bool
    case permission
    case scale(ClosedRange<Int>)
    case text

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        switch name {
        case "bool":
            self = .bool
        case "permission":
            // TODO
            self = .permission
        case "scale":
            let range = try container.decode([Int].self, forKey: .value)
            self = .scale((range.first ?? 0)...(range.last ?? 10))
        case "text":
            self = .text
        default:
            throw DecodingError.dataCorruptedError(forKey: .name, in: container, debugDescription: "Unknown `name`: \(name)")
        }
    }
}
