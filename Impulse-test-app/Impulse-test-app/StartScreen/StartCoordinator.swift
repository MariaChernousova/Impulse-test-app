//
//  StartCoordinator.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class StartCoordinator: Coordinator {
    
    enum Path {
        case carousel
    }
    
    let serviceManager: ServiceManager
    
    lazy var rootViewController: UIViewController = {
        let viewModel = StartViewModel { path in
            switch path {
            case .carousel:
                self.startCarouselFlow()
            }
        }
        return StartViewController(viewModel: viewModel)
    }()
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func start() { }
    
    private func startCarouselFlow() {
        CarouselCoordinator(serviceManager: serviceManager, rootViewController: rootViewController).start()
    }
}
