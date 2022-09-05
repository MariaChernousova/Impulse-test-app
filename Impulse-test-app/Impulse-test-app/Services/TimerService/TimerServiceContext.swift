//
//  TimerServiceContext.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

protocol TimerServiceContext {
    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        repeats: Bool,
        fireQueue: DispatchQueue,
        fireHandler: @escaping (TimerService?, AnyHashable) -> Void
    )
    func invalidateTimerWithIdentifier(_ identifier: AnyHashable)
    func invalidateAll()
}
