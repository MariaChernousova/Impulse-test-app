//
//  TimerService.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

class TimerService: TimerServiceContext {
    private var timers: [AnyHashable: Timer] = [:]
    private let timerQueue = DispatchQueue(label: "come.TimerServiceImpl.serial.queue")
    
    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        repeats: Bool,
        fireQueue: DispatchQueue,
        fireHandler: @escaping (TimerService?, AnyHashable) -> Void
    ) {
        timerQueue.async {
            let identifier = UUID()
            let timer = Timer(timeInterval: interval, repeats: repeats) { _ in
                fireQueue.async { [weak self] in
                    fireHandler(self, identifier)
                }
            }
            self.timers[identifier] = timer
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    func invalidateTimerWithIdentifier(_ identifier: AnyHashable) {
        timers.removeValue(forKey: identifier)?.invalidate()
    }
    
    func invalidateAll() {
        timers.values.forEach { $0.invalidate() }
        timers.removeAll()
    }
}
