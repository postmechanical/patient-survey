//
//  AppDelegate.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var patientSurveyCoordinator: PatientSurveyCoordinator = {
        PatientSurveyCoordinator(UINavigationController())
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        patientSurveyCoordinator.start()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = patientSurveyCoordinator.navigationController
        window.makeKeyAndVisible()
        return true
    }
}

