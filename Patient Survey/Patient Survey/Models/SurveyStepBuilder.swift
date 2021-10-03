//
//  SurveyStepBuilder.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import Foundation

@dynamicMemberLookup
struct SurveyStepBuilder {
    static let regex = try? NSRegularExpression(pattern: "(?:\\{[a-z\\.]*\\})", options: .caseInsensitive)

    let appointment: Appointment
    let diagnosis: Diagnosis
    let doctor: Doctor
    let patient: Patient
    let template: SurveyStepTemplate
    
    func makeSurveyStep() -> SurveyStep? {
        switch template.promptType {
        case "text":
            return SurveyStep(prompt: .text(substituteKeyPaths(in: template.template)), responseType: template.responseType)
        case "permission":
            let prompt: SurveyPrompt
            switch template.template {
            case "camera":
                prompt = .permission(.camera)
            case "location":
                prompt = .permission(.location)
            default:
                return nil
            }
            return SurveyStep(prompt: prompt, responseType: template.responseType)
        default:
            return nil
        }
    }
    
    func substituteKeyPaths(in template: String) -> String {
        guard let regex = Self.regex else {
            // Should never happen!
            // Personal favorite comment ☝️😝
            return template
        }
        var substitutedTemplate = template
        let matches = regex.matches(in: template, options: .withoutAnchoringBounds, range: NSRange(location: 0, length: template.count))
        matches.forEach { result in
            let startIndex = template.index(template.startIndex, offsetBy: result.range.location)
            let endIndex = template.index(startIndex, offsetBy: result.range.length - 1)
            let keyPathStringTemplate = template[startIndex...endIndex]
            var keyPathString = String(keyPathStringTemplate)
            keyPathString.removeFirst()
            keyPathString.removeLast()
            // Sure would be nice if `KeyPath` could be instantiated from `String` right about now. 😩
            guard let value = self[dynamicMember: keyPathString] else {
                return
            }
            substitutedTemplate = substitutedTemplate.replacingOccurrences(of: keyPathStringTemplate, with: value)
        }
        return substitutedTemplate
    }
    
    subscript(dynamicMember string: String) -> String? {
        let components = string.split(separator: ".")
        let subKeyPath = components[1...components.count - 1].joined(separator: ".")
        switch components.first {
        case "appointment":
            return appointment[dynamicMember: subKeyPath]
        case "diagnosis":
            return diagnosis[dynamicMember: subKeyPath]
        case "doctor":
            return doctor[dynamicMember: subKeyPath]
        case "patient":
            return patient[dynamicMember: subKeyPath]
        default:
            return nil
        }
    }
}
