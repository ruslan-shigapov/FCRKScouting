//
//  AppDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 08.04.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func setupUIAppearance() {
        UITextField.appearance().tintColor = .accent
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any
        ]?
    ) -> Bool {
//        StorageManager.shared.fetchPlayers { _ in }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupUIAppearance()
        ScreenFactory.setRootViewController()
        return true
    }
}
