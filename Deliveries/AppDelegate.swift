//
//  AppDelegate.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = UINavigationController()
        let mainController = DeliveryListViewController(nibName: nil, bundle: nil)
        navController.viewControllers = [mainController]
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

