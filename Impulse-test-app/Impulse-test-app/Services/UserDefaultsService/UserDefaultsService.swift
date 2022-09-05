//
//  UserDefaultsService.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 05.09.2022.
//

import Foundation

class UserDefaultsService: UserDefaultsServiceContext {
    
    @propertyWrapper
    struct Storage<T: Codable> {
        private let key: String
        private let defaultValue: T
        
        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        
        var wrappedValue: T {
            get {
                guard let data = UserDefaults.standard.object(forKey: key) as? Data,
                      let value = try? JSONDecoder().decode(T.self, from: data) else {
                    return defaultValue
                }
                return value
            }
            set {
                let data = try? JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    @Storage(key: "com.impulse.test.app.isloggedin.key", defaultValue: false)
    var isLoggedIn: Bool
}
