//
//  AppDelegate.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.value(forKey: "DarkMode") == nil {
            UserDefaults.standard.set(false, forKey: "DarkMode")
        }
        
        FirebaseApp.configure()
        return true
    }
}

