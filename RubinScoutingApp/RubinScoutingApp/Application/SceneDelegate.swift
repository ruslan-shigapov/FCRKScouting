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
            if let currentUser = UserManager.shared.user {
                window.rootViewController = ModuleFactory.shared.getMainVC(
                    forUser: currentUser)
            } else {
                window.rootViewController = ModuleFactory.shared.getLoginVC()
            }
        }
    }
}
