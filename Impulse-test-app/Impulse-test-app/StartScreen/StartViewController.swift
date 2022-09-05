//
//  ViewController.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class StartViewController: UIViewController {
        
    private lazy var startButton: TemplateButton = {
        let button = TemplateButton(frame: .zero)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: StartViewModelProvider
    
    init(viewModel: StartViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        commonInit()
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
    }

    private func setupSubviews() {
        view.addSubview(startButton)
    }
    
    private func setupAutoLayout() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 52),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 66),
            startButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -66)
        ])
    }
    
    @objc private func buttonTapped() {
        viewModel.select()
    }
}
