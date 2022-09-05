//
//  ServiceManager.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

protocol ServiceManager {
    var timerService: TimerServiceContext { get }
    var userDefaultsService: UserDefaultsServiceContext { get }
}
