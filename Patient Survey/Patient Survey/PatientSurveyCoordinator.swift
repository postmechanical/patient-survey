//
//  PatientSurveyCoordinator.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import PhotosUI
import UIKit

class PatientSurveyCoordinator: Coordinator {
    let navigationController: NavigationControlling
    let patientSurveyStore: PatientSurveyStoreProtocol
    
    private var survey: Survey?
    private var currentStepIndex = 0
    private var permissionCompletion: ((Any?) -> Void)?
    
    init(navigationController: NavigationControlling, patientSurveyStore: PatientSurveyStoreProtocol) {
        self.navigationController = navigationController
        self.patientSurveyStore = patientSurveyStore
    }
    
    func start() {
        guard let patientId = UUID(uuidString: "6739ec3e-93bd-11eb-a8b3-0242ac130003"),
              let survey = patientSurveyStore.survey(for: patientId),
              let step = survey.steps.first
        else {
            return
        }
        self.survey = survey
        currentStepIndex = 0
        guard let surveyStepViewController = buildSurveyStepViewController(for: step) else {
            return
        }
        navigationController.setViewControllers([surveyStepViewController], animated: true)
    }
    
    func next(add response: SurveyResponse?) {
        let nextStepIndex = currentStepIndex + 1
        guard let survey = survey else {
            return
        }
        if let response = response {
            patientSurveyStore.addSurveyResponse(response, for: survey.patient)
        }
        guard nextStepIndex < survey.steps.count else {
            finish()
            return
        }
        currentStepIndex = nextStepIndex
        guard let surveyStepViewController = buildSurveyStepViewController(for: survey.steps[nextStepIndex]) else {
            return
        }
        navigationController.pushViewController(surveyStepViewController, animated: true)
    }
    
    func finish() {
        guard let survey = survey,
            let summary = patientSurveyStore.getSurveySummary(for: survey.patient)
        else {
            return
        }
        let surveySummaryViewController = SurveySummaryViewController(coordinator: self, summary: summary)
        navigationController.setViewControllers([surveySummaryViewController], animated: true)
    }
    
    func promptFor(permission: PermissionType, completion: ((Any?) -> Void)?) {
        switch permission {
        case .camera:
            var configuration = PHPickerConfiguration(photoLibrary: .shared())
            configuration.selectionLimit = 1
            configuration.filter = .images
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            permissionCompletion = completion
            navigationController.present(picker, animated: true, completion: nil)
        case .location:
            // TODO
            break
        }
    }
    
    private func buildSurveyStepViewController(for step: SurveyStep) -> SurveyStepViewController? {
        guard let survey = survey else {
            return nil
        }
        let surveyStepViewController = SurveyStepViewController(coordinator: self, step: step)
        surveyStepViewController.title = String(format: NSLocalizedString("Step %i of %i", comment: ""), currentStepIndex + 1, survey.steps.count)
        return surveyStepViewController
    }
}

extension PatientSurveyCoordinator: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        guard let result = results.first else {
            permissionCompletion?(nil)
            return
        }
        result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
            DispatchQueue.main.async {
                self.permissionCompletion?(image as? UIImage)
            }
        }
    }
}
