//
//  AppDelegate.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 02/10/20.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManagerSwift.IQKeyboardManager.shared.enable = true
        
//        let defaults = UserDefaults.standard
//        print(defaults.bool(forKey: "hasOpenedBefore"))
//        print(defaults.bool(forKey: "darkMode"))
//        if (defaults.bool(forKey: "hasOpenedBefore") == false) {
//            defaults.setValue(true, forKey: "hasOpenedBefore")
//            print("Never Opened before")
//            defaults.setValue(true, forKey: "darkMode")
//            window?.overrideUserInterfaceStyle = .dark
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = .dark
//            }
//        } else {
//            if defaults.bool(forKey: "darkMode") == true {
//                window?.overrideUserInterfaceStyle = .dark
//                UIApplication.shared.windows.forEach { window in
//                    window.overrideUserInterfaceStyle = .dark
//                }
//            } else {
//                window?.overrideUserInterfaceStyle = .light
//                UIApplication.shared.windows.forEach { window in
//                    window.overrideUserInterfaceStyle = .light
//                }
//            }
//        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

