//
//  PatientSurveyCoordinator.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

class PatientSurveyCoordinator: Coordinator {
    let navigationController: NavigationControlling
    
    init(_ navigationController: NavigationControlling) {
        self.navigationController = navigationController
    }

    func start() {
        let rootViewController = ViewController()
        navigationController.pushViewController(rootViewController, animated: false)
    }
}
