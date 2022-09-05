//
//  UserDefaultsServiceContext.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 05.09.2022.
//

import Foundation

protocol UserDefaultsServiceContext: AnyObject {
    var isLoggedIn: Bool { get set }
}
