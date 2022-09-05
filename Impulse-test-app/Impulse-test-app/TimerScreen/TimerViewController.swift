//
//  TimerViewController.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import UIKit

class TimerViewController: UIViewController {
    
    private lazy var timerView: TimerView = {
        let view = TimerView(frame: .zero)
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = 28.0
        return view
    }()
    
    private var viewModel: TimerViewModelProvider
    
    init(viewModel: TimerViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindWithViewModel()
        viewModel.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.didAppear()
    }
    
    private func setupUI() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .backgroundPrimary.withAlphaComponent(0.5)
        view.addSubview(timerView)
    }
    
    private func setupAutoLayout() {
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func bindWithViewModel() {
        viewModel.setUpdateDataHandler { [weak timerView] data, dismissHandler in
            timerView?.setup(with: data, tapHandler: dismissHandler)
        }
    }
}
