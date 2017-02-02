//
//  AppDelegate.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UserNotificationManager.shared.registerNotification()
        
        return true
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Complete")
        completionHandler(UIBackgroundFetchResult.newData)
        
        application.setMinimumBackgroundFetchInterval(100)
        
        let defaults = UserDefaults.standard
        let count = defaults.integer(forKey: "countProducts")
        
        getCountProducts(currentCount: count)
        //UserNotificationManager.shared.addNotification(text: "LOL")
    }
    
    func getCountProducts(currentCount : Int) {
        let dataManager = DataManager()
        dataManager.sendPostsForCategoryRequest(category: "tech", success: { (products) in
            let newCounts = products.count - currentCount
            if (newCounts) == 1 {
                UserNotificationManager.shared.addNotificationProduct(product: products[0])
            } else if newCounts > 1 {
                UserNotificationManager.shared.addNotificationCount(count: newCounts)
            }
        }, failyre: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

