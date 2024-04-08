//
//  ScreenFactory.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

struct ScreenFactory {
        
    static func setRootViewController() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let currentUser = UserManager.shared.user {
            appDelegate?.window?.rootViewController = getMainViewController(
                forUser: currentUser)
        } else {
            appDelegate?.window?.rootViewController = getLoginViewController()
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
    
    static func getAddPlayerViewController() -> UIViewController {
        AddPlayerViewController()
    }
    
    static func getFiltersViewController() -> UIViewController {
        FiltersViewController()
    }
}
