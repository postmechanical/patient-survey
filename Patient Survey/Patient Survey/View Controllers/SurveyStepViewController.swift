//
//  SurveyStepViewController.swift
//  Patient Survey
//
//  Created by Aaron London on 10/1/21.
//

import UIKit

class SurveyStepViewController: UIViewController {
    private weak var coordinator: Coordinator?
    private let step: SurveyStep
    private var nextButton: UIBarButtonItem!
    private var response: SurveyResponse? {
        didSet {
            nextButton.isEnabled = (response != nil)
        }
    }
    
    init(coordinator: Coordinator, step: SurveyStep) {
        self.coordinator = coordinator
        self.step = step
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        let stepView = step.makeView { [weak self] response in
            self?.response = response
        }
        stepView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepView)
        NSLayoutConstraint.activate([
            stepView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stepView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stepView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stepView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        let nextButton = UIBarButtonItem(title: NSLocalizedString("Next", comment: ""), image: nil, primaryAction: .init(handler: { [weak self] action in
            self?.coordinator?.next(add: self?.response)
        }), menu: nil)
        navigationItem.rightBarButtonItem = nextButton
        nextButton.isEnabled = step.nextButtonStartsEnabled
        self.nextButton = nextButton
    }
}

