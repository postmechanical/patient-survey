//
//  PatientSurveyCoordinator.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

class PatientSurveyCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let rootViewController = ViewController()
        navigationController.pushViewController(rootViewController, animated: false)
    }
}
