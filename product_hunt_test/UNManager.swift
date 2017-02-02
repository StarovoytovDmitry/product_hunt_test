//
//  UNManager.swift
//  product_hunt_test
//
//  Created by Дмитрий on 02.02.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit
import UserNotifications

class UserNotificationManager {
    
    static let shared = UserNotificationManager()
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted:Bool, error:Error?) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            if granted {
                print("Permission granted")
            } else {
                print("Permission not granted")
            }
        }
    }
    
    func addNotification() {
        let content = self.contentWith("Hi")
        self.addDelayNotificationWith(content)
    }
    
    func contentWith(_ subtitle: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "Title"
        content.subtitle = subtitle
        content.body = "Body"
        content.sound = UNNotificationSound.default()
        
        return content
    }
    
    func addDelayNotificationWith(_ content: UNNotificationContent) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let request = UNNotificationRequest(identifier: "Noty", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print("Add notification: \((error != nil) ? "error" : "success")")
        }
    }

    
}

/*
extension UserNotificationManager: UNUserNotificationCenterDelegate {
 
    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge])
    }
}
*/
