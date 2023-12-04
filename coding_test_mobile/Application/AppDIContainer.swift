//
//  AppDIContainer.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/5/23.
//

import Foundation

class AppDIContainer {
    static let shared = AppDIContainer()
    
    private init() {}
    
    private var services: [String: Any] = [:]
    
    func registerService<T>(_ serviceType: T.Type, instance: T) {
        let key = String(describing: serviceType)
        services[key] = instance
    }
    
    func resolveService<T>(_ serviceType: T.Type) -> T? {
        let key = String(describing: serviceType)
        return services[key] as? T
    }
}
