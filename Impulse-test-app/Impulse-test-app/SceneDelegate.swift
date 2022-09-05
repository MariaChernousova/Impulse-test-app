//
//  SceneDelegate.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator?
    private lazy var serviceLocator = ServiceLocator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        configureServices()
                
        appCoordinator = AppCoordinator(window: window, serviceManager: serviceLocator)
        appCoordinator?.start()
    }
}

extension SceneDelegate {
    private func configureServices() {
        let timerService: TimerServiceContext = TimerService()
        serviceLocator.register(timerService)
        
        let userDefaultsService: UserDefaultsServiceContext = UserDefaultsService()
        serviceLocator.register(userDefaultsService)
    }
}
