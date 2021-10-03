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
        PatientSurveyCoordinator(UINavigationController(nibName: nil, bundle: nil))
    }()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        patientSurveyCoordinator.start()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = patientSurveyCoordinator.navigationController as? UINavigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

