//
//  TimerCoordinator.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import UIKit

class TimerCoordinator: Coordinator {
    
    enum Path {
        case dismiss
    }
    
    let serviceManager: ServiceManager
    var rootViewController: UIViewController
    
    init(serviceManager: ServiceManager,
         rootViewController: UIViewController) {
        self.serviceManager = serviceManager
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = TimerModel(timerService: serviceManager.timerService)
        let viewModel = TimerViewModel(model: model) { path in
            switch path {
            case .dismiss:
                self.dismissTimerFlow()
            }
        }
        
        let viewController = TimerViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        
        rootViewController.present(viewController, animated: true)
    }
    
    private func dismissTimerFlow() {
        rootViewController.dismiss(animated: true)
        serviceManager.userDefaultsService.isLoggedIn = true
    }
}
