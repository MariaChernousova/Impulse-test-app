//
//  NSObject+Extensions.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

extension NSObject {
    static var identifier: String {
        "\(String(describing: self))Identifier"
    }
}
