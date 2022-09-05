//
//  AppCoordinator.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let serviceManager: ServiceManager
    
    init(window: UIWindow, serviceManager: ServiceManager) {
        self.window = window
        self.serviceManager = serviceManager
    }
    
    func start() {
        startMainCoordinator()
        window.makeKeyAndVisible()
    }
    
    private func startMainCoordinator() {
        let coordinator = StartCoordinator(serviceManager: serviceManager)
        window.rootViewController = coordinator.rootViewController
    }
}
