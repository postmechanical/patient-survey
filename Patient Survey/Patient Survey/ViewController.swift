//
//  ViewController.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

class ViewController: UIViewController {
    override func loadView() {
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Patient Survey"
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 18)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

