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
    let data: Any?

    init(text: String, commentary: String? = nil, data: Any? = nil) {
        self.text = text
        self.commentary = commentary
        self.data = data
    }
}
