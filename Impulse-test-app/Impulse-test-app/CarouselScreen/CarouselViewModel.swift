//
//  CarouselViewModel.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import Foundation

typealias AlertData = (title: String, message: String)

protocol CarouselViewModelProvider {
    func setShowAlertHandler(_ showAlertHandler: @escaping (AlertData) -> Void)
    func select()
}

class CarouselViewModel: CarouselViewModelProvider {
    
    typealias PathHandler = (CarouselCoordinator.Path) -> Void
    
    private var showAlertHandler: ((AlertData) -> Void)?
    
    private let model: CarouselModelProvider
    private let pathHandler: PathHandler
    
    init(model: CarouselModelProvider, pathHandler: @escaping PathHandler) {
        self.model = model
        self.pathHandler = pathHandler
    }
    
    func setShowAlertHandler(_ showAlertHandler: @escaping (AlertData) -> Void) {
        self.showAlertHandler = showAlertHandler
    }
    
    func select() {
        if model.isLoggedIn {
            let alertData = (
                title: "Thank you for your interest",
                message: "The functionality is under development"
            )
            showAlertHandler?(alertData)
        } else {
            pathHandler(.timer)
        }
    }
}
