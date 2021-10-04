//
//  SurveyStep.swift
//  Patient Survey
//
//  Created by Aaron London on 10/2/21.
//

import UIKit

struct SurveyStep {
    let prompt: SurveyPrompt
    let responseType: SurveyResponseType
    
    var nextButtonStartsEnabled: Bool {
        switch responseType {
        case .bool:
            return true
        case .permission:
            return false
        case .scale(_):
            return true
        case .text:
            return false
        }
    }
    
    func makeView(coordinator: Coordinator?, responseHandler: ((SurveyResponse) -> Void)?) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let promptView: UIView
        switch prompt {
        case .text(let string):
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title1), size: 24)
            label.text = string
            label.textAlignment = .left
            promptView = label
        case .permission(let string, let permissionType):
            let permissionStackView = UIStackView()
            permissionStackView.axis = .vertical
            permissionStackView.distribution = .fillProportionally
            permissionStackView.spacing = 8
            permissionStackView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title1), size: 24)
            label.text = string
            label.textAlignment = .left
            permissionStackView.addArrangedSubview(label)
            switch permissionType {
            case .camera:
                let cameraButton = UIButton(frame: .zero, primaryAction: .init(handler: { action in
                    coordinator?.promptFor(permission: permissionType, completion: { image in
                        responseHandler?(SurveyResponse.permission(image != nil, permissionType, image as? UIImage))
                    })
                }))
                cameraButton.configuration = .borderedProminent()
                cameraButton.configuration?.image = UIImage(systemName: "camera.fill")
                cameraButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                permissionStackView.addArrangedSubview(cameraButton)
            case .location:
                // TODO:
                break
            }
            promptView = permissionStackView
            break
        }
        promptView.setContentHuggingPriority(.required, for: .vertical)
        promptView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        promptView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(promptView)

        let hintLabel: UILabel
        let responseView: UIView
        switch responseType {
        case .bool:
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .callout), size: 14)
            label.text = NSLocalizedString("Toggle switch to select value and continue.", comment: "")
            label.textAlignment = .center
            hintLabel = label
            let toggle = UISwitch(frame: .zero, primaryAction: .init(handler: { action in
                guard let sender = action.sender as? UISwitch else {
                    return
                }
                responseHandler?(SurveyResponse.bool(sender.isOn))
            }))
            responseHandler?(SurveyResponse.bool(toggle.isOn))
            responseView = toggle
        case .permission:
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .callout), size: 14)
            label.text = NSLocalizedString("Tap button to grant permission to upload data and continue.", comment: "")
            label.textAlignment = .center
            hintLabel = label
            // TODO
            responseView = UIView()
        case .scale(let range):
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .callout), size: 14)
            label.text = NSLocalizedString("Adjust slider to select value and continue.", comment: "")
            label.textAlignment = .center
            hintLabel = label
            let slider = UISlider(frame: .zero, primaryAction: .init(handler: { action in
                guard let sender = action.sender as? UISlider else {
                    return
                }
                responseHandler?(SurveyResponse.scale(range, Int(sender.value)))
            }))
            slider.minimumValue = Float(range.first ?? 0)
            slider.maximumValue = Float(range.last ?? 10)
            responseHandler?(SurveyResponse.scale(range, Int(slider.minimumValue)))
            responseView = slider
        case .text:
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .callout), size: 14)
            label.text = NSLocalizedString("Type response and hit enter key to continue.", comment: "")
            label.textAlignment = .center
            hintLabel = label
            let textField = UITextField(frame: .zero, primaryAction: .init(handler: { action in
                guard let sender = action.sender as? UITextField, let text = sender.text else {
                    return
                }
                responseHandler?(SurveyResponse.text(text))
            }))
            textField.backgroundColor = .black.withAlphaComponent(0.1)
            textField.borderStyle = .roundedRect
            textField.contentVerticalAlignment = .top
            textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 24)
            textField.textAlignment = .left
            responseView = textField
        }
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(hintLabel)
        responseView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(responseView)

        return stackView
    }
}
