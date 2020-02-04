//
//  AppDelegate.swift
//  Caching
//
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let cache = NasaURLCache(memoryCapacity: 1024 * 1024 * 30, diskCapacity: 1024 * 1024 * 100, diskPath: nil)
        URLCache.shared = cache
        return true
    }
}
