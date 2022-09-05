//
//  TemplateButton.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

protocol TemplateButtonConfigurable {
    var backgroundColor: UIColor { get }
}

struct TemplateButtonConfiguration {
    private struct Enabled: TemplateButtonConfigurable {
        var backgroundColor: UIColor = .contentAccent
    }
    
    private struct Disabled: TemplateButtonConfigurable {
        var backgroundColor: UIColor = .contentAccentDisabled
    }
    
    static let enabled: TemplateButtonConfigurable = Enabled()
    static let disabled: TemplateButtonConfigurable = Disabled()
}

class TemplateButton: UIButton {
    enum State {
        case enabled
        case disabled
    }
    
    override var isEnabled: Bool {
        didSet {
            update()
        }
    }
    
    private let configurations: [State: TemplateButtonConfigurable] = [
        .enabled: TemplateButtonConfiguration.enabled,
        .disabled: TemplateButtonConfiguration.disabled
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10.0
        titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        update()
    }
    
    private func update() {
        guard let enabledConfiguration = configurations[.enabled],
              let disabledConfiguration = configurations[.disabled] else { return }
        backgroundColor = isEnabled ?
        enabledConfiguration.backgroundColor :
        disabledConfiguration.backgroundColor
    }
}
