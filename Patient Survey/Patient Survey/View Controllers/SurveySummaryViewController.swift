//
//  SurveySummaryViewController.swift
//  Patient Survey
//
//  Created by Aaron London on 10/3/21.
//

import UIKit

class SurveySummaryViewController: UIViewController {
    private weak var coordinator: Coordinator?
    private let summary: [Summary]
    
    init(coordinator: Coordinator, summary: [Summary]) {
        self.coordinator = coordinator
        self.summary = summary
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        title = NSLocalizedString("Summary", comment: "")
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])

        let titleLabel = UILabel()
        titleLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 32)
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString("Thanks again! Here’s what we heard:", comment: "")
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stackView.addArrangedSubview(titleLabel)
        
        summary.enumerated().forEach { index, item in
            let itemLabel = UILabel()
            itemLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16)
            itemLabel.numberOfLines = 0
            itemLabel.text = String(format: NSLocalizedString("%i: %@", comment: ""), index + 1, item.text)
            itemLabel.textColor = .black
            itemLabel.translatesAutoresizingMaskIntoConstraints = false
            itemLabel.setContentHuggingPriority(.required, for: .vertical)
            itemLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            stackView.addArrangedSubview(itemLabel)
            
            if let commentary = item.commentary {
                let commentaryLabel = UILabel()
                commentaryLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .callout), size: 14)
                commentaryLabel.numberOfLines = 0
                commentaryLabel.text = commentary
                commentaryLabel.textColor = .darkGray
                commentaryLabel.translatesAutoresizingMaskIntoConstraints = false
                commentaryLabel.setContentHuggingPriority(.required, for: .vertical)
                commentaryLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
                stackView.addArrangedSubview(commentaryLabel)
            }
        }
        
        let doneButton = UIBarButtonItem(systemItem: .done, primaryAction: .init(handler: { [weak self] _ in
            self?.coordinator?.start()
        }), menu: nil)
        navigationItem.rightBarButtonItem = doneButton
    }
}
