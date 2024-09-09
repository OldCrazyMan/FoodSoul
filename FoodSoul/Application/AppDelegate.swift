//
//  AppDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//
// AppDelegate.swift

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Сonstants
    private let navigationBarTextColor = UIColor.white
    private let orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBar()
        return true
    }

    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: navigationBarTextColor]
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
