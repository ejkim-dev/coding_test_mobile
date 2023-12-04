//
//  AppDelegate.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let container = AppDIContainer.shared
        let repository = LiveRepositoryImpl()
        let useCase = LiveUseCaseImpl(liveRepository: repository)
        let viewModel = MainViewModel(liveUseCase: useCase)
        
        container.registerService(MainViewModel.self, instance: viewModel)
        
        // Override point for customization after application launch.
        return true
    }
}

