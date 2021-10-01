//
//  AppDelegate.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: ViewController())
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
}

