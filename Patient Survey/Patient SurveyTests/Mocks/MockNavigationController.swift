//
//  MockNavigationController.swift
//  Patient SurveyTests
//
//  Created by Aaron London on 10/1/21.
//

import Mokka
import UIKit

@testable import Patient_Survey

class MockNavigationController: NavigationControlling {
    let pushViewController = FunctionMock<(viewController: UIViewController, animated: Bool)>()
    let setViewControllers = FunctionMock<(viewControllers: [UIViewController], animated: Bool)>()
    let present = FunctionMock<(viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)>()
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewController.recordCall((viewController, animated))
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllers.recordCall((viewControllers, animated))
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        present.recordCall((viewControllerToPresent, flag, completion))
    }
}
