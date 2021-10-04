//
//  Coordinator.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: NavigationControlling { get }
    func start()
    func next(add response: SurveyResponse?)
    func finish()
    func promptFor(permission: PermissionType, completion: ((Any?) -> Void)?)
}
