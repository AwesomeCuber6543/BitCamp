//
//  SceneDelegate.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            // Create a UIWindow using the windowScene constructor which takes a UIWindowScene instance
            let window = UIWindow(windowScene: windowScene)

            // Initialize your HomePageViewController
            let homePageViewController = HomePageViewController()
            
            // Create a UINavigationController with HomePageViewController as its rootViewController
            let navigationController = UINavigationController(rootViewController: homePageViewController)
            
            // Set the UINavigationController as the rootViewController of the window
            window.rootViewController = navigationController
            
            // Set the window and make it visible
            self.window = window
            window.makeKeyAndVisible()
        }



}
