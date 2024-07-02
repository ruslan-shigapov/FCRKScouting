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
        if UserManager.shared.getCurrentUser() == nil {
            appDelegate?.window?.rootViewController = getLoginViewController()
        } else {
            appDelegate?.window?.rootViewController = MainTabBarController()
        }
    }
    
    static func getLoginViewController() -> UIViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
    
    static func getFormController(
        withDelegate delegate: FormViewControllerDelegate?
    ) -> UIViewController {
        let viewModel = FormViewModel()
        let viewController = FormViewController(
            viewModel: viewModel,
            delegate: delegate)
        return viewController
    }
    
    static func getMainTabBarController() -> UIViewController {
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        return tabBarController
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
    
    static func getEditorViewControllerWith(
        delegate: EditorViewControllerDelegate,
        andPlayer player: Player?
    ) -> UIViewController {
        let viewModel = EditorViewModel(player: player)
        let viewController = EditorViewController(
            viewModel: viewModel,
            delegate: delegate)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    static func getCareerDetailsVC() -> UIViewController {
        CareerDetailsViewController()
    }
    
    static func getTransferDetailsVCWith(
        delegate: TransferDetailsViewControllerDelegate
    ) -> UIViewController {
        TransferDetailsViewController(delegate: delegate)
    }
    
    static func getPlayerViewControllerFor(
        player: Player,
        withDelegate delegate: PlayerViewControllerDelegate
    ) -> UIViewController {
        let viewModel = PlayerViewModel(player: player)
        return PlayerViewController(viewModel: viewModel, delegate: delegate)
    }
    
    static func getTestingDetailsVC() -> UIViewController {
        TestingDetailsViewController()
    }
    
    static func getFiltersViewController() -> UIViewController {
        FiltersViewController()
    }
}
