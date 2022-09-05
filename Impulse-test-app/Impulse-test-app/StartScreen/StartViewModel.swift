//
//  StartViewModel.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import Foundation

protocol StartViewModelProvider {
    func select()
}

class StartViewModel: StartViewModelProvider {
    
    typealias PathHandler = (StartCoordinator.Path) -> Void
    
    private let pathHandler: PathHandler
    
    init(pathHandler: @escaping PathHandler) {
        self.pathHandler = pathHandler
    }
    
    func select() {
        pathHandler(.carousel)
    }
}
