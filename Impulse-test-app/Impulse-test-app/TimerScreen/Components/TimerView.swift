//
//  TimerView.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import UIKit

protocol TimerViewDataProvider {
    var timerText: String { get }
    var buttonTitle: String { get }
    var isButtonEnabled: Bool { get }
    var progress: Float { get }
}

class TimerView: UIView {
    
    private var tapHandler: (() -> Void)?
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 68.0, weight: .semibold)
        label.textColor = .contentPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .contentAccent
        progressView.trackTintColor = .contentPrimary.withAlphaComponent(0.25)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 5
        progressView.subviews[1].clipsToBounds = true
        
        return progressView
    }()
    
    private lazy var button: TemplateButton = {
        let button = TemplateButton(frame: .zero)
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with data: TimerViewDataProvider, tapHandler: @escaping () -> Void) {
        timerLabel.text = data.timerText
        button.setTitle(data.buttonTitle, for: .normal)
        button.isEnabled = data.isButtonEnabled
        progressView.setProgress(data.progress, animated: true)
        self.tapHandler = tapHandler
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        addSubview(timerLabel)
        addSubview(progressView)
        addSubview(button)
    }
    
    private func setupAutoLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.heightAnchor.constraint(equalToConstant: 78),
            timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 96),
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            
            progressView.heightAnchor.constraint(equalToConstant: 8),
            progressView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            
            button.heightAnchor.constraint(equalToConstant: 52),
            button.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 108),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    @objc private func buttonTapped() {
        tapHandler?()
    }
}
