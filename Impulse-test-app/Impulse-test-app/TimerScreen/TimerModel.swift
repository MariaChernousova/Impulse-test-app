//
//  TimerModel.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

protocol TimerModelProvider: AnyObject {
    func scheduledRepeatedTimer(
        withTimeInterval interval: TimeInterval,
        fireHandler: @escaping () -> Void
    )
    func invalidateTimer()
}

class TimerModel: TimerModelProvider {
    
    private let timerService: TimerServiceContext
    
    init(timerService: TimerServiceContext) {
        self.timerService = timerService
    }
    
    func scheduledRepeatedTimer(
        withTimeInterval interval: TimeInterval,
        fireHandler: @escaping () -> Void
    ) {
        timerService.scheduledTimer(
            withTimeInterval: interval,
            repeats: true,
            fireQueue: .main) { _, _ in
                fireHandler()
            }
    }
    
    func invalidateTimer() {
        timerService.invalidateAll()
    }
}
