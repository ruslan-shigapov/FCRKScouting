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
        if UserManager.shared.user != nil {
            appDelegate?.window?.rootViewController = MainTabBarController()
        } else {
            appDelegate?.window?.rootViewController = getLoginViewController()
        }
    }
    
    static func getMainTabBarController() -> UIViewController {
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        return tabBarController
    }
    
    static func getLoginViewController() -> UIViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
    
    static func getUpdatesViewController() -> UIViewController {
        let viewModel = UpdatesViewModel()
        return UpdatesViewController(viewModel: viewModel)
    }
    
    static func getSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel()
        return SearchViewController(viewModel: viewModel)
    }
    
    static func getProfileViewController() -> UIViewController {
        let viewModel = ProfileViewModel()
        return ProfileViewController(viewModel: viewModel)
    }
    
    static func getPlayerAddingViewController() -> UIViewController {
        let viewModel = PlayerAddingViewModel()
        let viewController = PlayerAddingViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    static func getFiltersViewController() -> UIViewController {
        FiltersViewController()
    }
}
