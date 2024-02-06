//
//  SceneDelegate.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let isDarkModeOn = UserDefaults.standard.bool(forKey: "DarkMode")
        applyDarkMode(isDarkModeOn)
        
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if !hasLaunchedBefore {
            let onboardingVC = OnboardingVC()
            onboardingVC.modalPresentationStyle = .fullScreen
            window?.rootViewController = onboardingVC
            
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            
        } else {
            let loginVC = LoginVC()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            window?.rootViewController = nav
        }
        
        if Auth.auth().currentUser != nil {
            let tabBar = MainTabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            window?.rootViewController = tabBar
        }
        self.window?.makeKeyAndVisible()
    }
    
    func applyDarkMode(_ isDarkModeOn: Bool) {
        if isDarkModeOn {
            if #available(iOS 13.0, *) {
                window?.overrideUserInterfaceStyle = .dark
            }
        } else {
            if #available(iOS 13.0, *) {
                window?.overrideUserInterfaceStyle = .light
            }
        }
    }
}

