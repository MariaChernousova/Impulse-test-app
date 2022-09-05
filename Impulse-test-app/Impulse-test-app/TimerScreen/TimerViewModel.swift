//
//  TimerViewModel.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

protocol TimerViewModelProvider {
    // Binding methods.
    func setUpdateDataHandler(_ updateDataHandler: @escaping (TimerViewDataProvider, @escaping () -> Void) -> Void)
    
    // Action methods.
    func didLoad()
    func didAppear()
}

class TimerViewModel: TimerViewModelProvider {
    
    typealias PathHandler = (TimerCoordinator.Path) -> Void
    
    private enum Constant {
        static let maxTimerValue = 5
    }
    
    // MARK: - Binding handlers.
    
    private var updateDataHandler: ((TimerViewDataProvider, @escaping () -> Void) -> Void)?
    
    // MARK: - State values.
    
    private var currentValue = -1 {
        didSet {
            syncCurrentState()
        }
    }
    
    private var isContinueEnabled = false {
        didSet {
            syncCurrentState()
        }
    }
    
    private let model: TimerModelProvider
    private let pathHandler: PathHandler
    
    init(model: TimerModelProvider, pathHandler: @escaping PathHandler) {
        self.model = model
        self.pathHandler = pathHandler
    }
    
    // MARK: - Binding methods.
    
    func setUpdateDataHandler(_ updateDataHandler: @escaping (TimerViewDataProvider, @escaping () -> Void) -> Void) {
        self.updateDataHandler = updateDataHandler
    }
    
    // MARK: - Public methods.
    
    func didLoad() {
        updateCurrentValue()
    }
    
    func didAppear() {
        model.scheduledRepeatedTimer(withTimeInterval: 1) { [weak self] in
            self?.updateCurrentValue()
        }
    }
    
    // MARK: - Private methods.
    
    private func updateCurrentValue() {
        currentValue += 1
        isContinueEnabled = false
        
        if currentValue == Constant.maxTimerValue {
            isContinueEnabled = true
            model.invalidateTimer()
        }
    }
    
    private func syncCurrentState() {
        let data = TimerViewData(
            maxValue: Constant.maxTimerValue,
            currentValue: currentValue,
            isContinueEnabled: isContinueEnabled
        )
        updateDataHandler?(data) { [weak self] in
            self?.handleDismiss()
        }
    }
    
    private func handleDismiss() {
        pathHandler(.dismiss)
    }
}
