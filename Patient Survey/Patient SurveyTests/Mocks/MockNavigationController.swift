//
//  MockNavigationController.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/1/21.
//

import Mokka

@testable import Patient_Survey
import UIKit

class MockNavigationController: NavigationControlling {
    let pushViewController = FunctionMock<(viewController: UIViewController, animated: Bool)>()
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewController.recordCall((viewController, animated))
    }
}
