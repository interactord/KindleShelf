//
//  AppDelegate.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let apiProvider = ApiNetworkProvider(network: Network())
        let service = Service(apiProvider: apiProvider)
        let viewModel = ShelfListViewModel(service: service)
        let viewController = ShelfListViewController()
        viewController.viewModel = viewModel

        let navController = ShelfNavigationController(rootViewController: viewController)
        window?.rootViewController = navController

        window?.makeKeyAndVisible()

        return false
    }

}
