//
//  SelectionViewController.swift
//  AppleMapUIKit
//
//  Created by Djallil Elkebir on 2023-01-10.
//

import UIKit
import SwiftUI

class SelectionViewController: UIViewController {
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        return stack
    }()
    
    private lazy var uikitSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("UIKit Version", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapUIKitButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var swiftuiSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SwiftUI Version", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapSwiftUIButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var uikitAppleMapController = MainViewController(viewModel: .init())
    
    private lazy var swiftUIMapController = UIHostingController(rootView: AppleMapUIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        configureViews()
    }

    private func setupStyle() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureViews() {
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vStack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        
        vStack.addArrangedSubviews([
            uikitSelectionButton,
            swiftuiSelectionButton
        ])
        
        NSLayoutConstraint.activate([
            swiftuiSelectionButton.heightAnchor.constraint(equalToConstant: 80),
            uikitSelectionButton.heightAnchor.constraint(equalToConstant: 80),
            swiftuiSelectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            uikitSelectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

// MARK: - Action(s)

extension SelectionViewController {
    @objc private func didTapUIKitButton(_ sender: UIButton) {
        navigationController?.pushViewController(uikitAppleMapController, animated: true)
    }
    
    @objc private func didTapSwiftUIButton(_ sender: UIButton) {
        navigationController?.pushViewController(swiftUIMapController, animated: true)
    }
}
