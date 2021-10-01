//
//  Coordinator.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
