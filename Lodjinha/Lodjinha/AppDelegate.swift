//
//  AppDelegate.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 03/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var applicationCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = AppCoordinator(window: window)
        applicationCoordinator?.start()

        return true
    }
}
