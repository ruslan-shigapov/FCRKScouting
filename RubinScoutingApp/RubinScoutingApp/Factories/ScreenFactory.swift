//
//  ScreenFactory.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

struct ScreenFactory {
    
    static func getRootViewController() -> UIViewController {
        if let currentUser = UserManager.shared.user {
            return getMainViewController(forUser: currentUser)
        } else {
            return getLoginViewController()
        }
    }
    
    static func getMainViewController(forUser user: User) -> UIViewController {
        let viewModel = ProfileViewModel(user: user)
        return MainTabBarController(viewModel: viewModel)
    }
    
    static func getLoginViewController() -> UIViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}
