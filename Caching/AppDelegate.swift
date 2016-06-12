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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let cache = NasaURLCache(memoryCapacity: 1024 * 1024 * 30, diskCapacity: 1024 * 1024 * 100, diskPath: nil)
        NSURLCache.setSharedURLCache(cache)
        return true
    }
}