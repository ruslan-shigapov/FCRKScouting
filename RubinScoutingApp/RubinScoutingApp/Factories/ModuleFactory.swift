//
//  ModuleFactory.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

struct ModuleFactory {
    
    static func getRootViewController() -> UIViewController {
        if let currentUser = UserManager.shared.user {
            return getMainViewController(forUser: currentUser)
        } else {
            return LoginViewController()
        }
    }
    
    static func getMainViewController(forUser user: User) -> UIViewController {
        let viewModel = MainViewModel(user: user)
        return MainViewController(viewModel: viewModel)
    }
}
