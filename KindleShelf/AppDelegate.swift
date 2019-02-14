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
        let viewModel = ShelfViewModel(services: service)
        let viewController = ShelfViewController.instantiate(viewModel: viewModel)
        let navigationController = KindleNavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()

        return false
    }

}
