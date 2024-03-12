//
//  SceneDelegate.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            window.rootViewController = UserManager.shared.isLoggedIn
            ? MainViewController()
            : LoginViewController()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

