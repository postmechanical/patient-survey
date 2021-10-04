//
//  Summarizable.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

protocol Summarizable {
    var summary: Summary { get }
}

struct Summary {
    let text: String
    let commentary: String?
}
