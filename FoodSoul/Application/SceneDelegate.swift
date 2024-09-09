//
//  SceneDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit
import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            createWindow(with: windowScene)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard (URLContexts.first?.url) != nil else {
            return
        }
    }

    private func createWindow(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createRootViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

    private func createRootViewController() -> UIViewController {
        return ContainerViewController()
    }
}
