//
//  NavigationControlling.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

protocol NavigationControlling {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}

extension UINavigationController: NavigationControlling {}
