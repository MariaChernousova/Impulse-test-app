//
//  CarouselCoordinator.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class CarouselCoordinator: Coordinator {
    
    enum Path {
        case timer
    }
    
    let serviceManager: ServiceManager
    var rootViewController: UIViewController
    
    init(serviceManager: ServiceManager,
         rootViewController: UIViewController) {
        self.serviceManager = serviceManager
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = CarouselModel(userDefaultsService: serviceManager.userDefaultsService)
        let viewModel = CarouselViewModel(model: model) { path in
            switch path {
            case .timer:
                self.startTimerFlow()
            }
        }
        
        let viewController = CarouselPageController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        
        rootViewController.present(viewController, animated: true)
        
        rootViewController = viewController
    }
    
    private func startTimerFlow() {
        TimerCoordinator(serviceManager: serviceManager, rootViewController: rootViewController).start()
    }
}

