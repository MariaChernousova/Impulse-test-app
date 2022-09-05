//
//  CarouselModel.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 05.09.2022.
//

import Foundation

protocol CarouselModelProvider {
    var isLoggedIn: Bool { get }
}

class CarouselModel: CarouselModelProvider {
    
    var isLoggedIn: Bool {
        userDefaultsService.isLoggedIn
    }
    
    private let userDefaultsService: UserDefaultsServiceContext
    
    init(userDefaultsService: UserDefaultsServiceContext) {
        self.userDefaultsService = userDefaultsService
    }
}
