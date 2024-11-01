//
//  ScreenFactory.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

struct ScreenFactory {
    
    private static func getLoginViewController() -> UIViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
        
    static func setRootViewController() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if UserManager.shared.getCurrentUser() == nil {
            appDelegate?.window?.rootViewController = getLoginViewController()
        } else {
            appDelegate?.window?.rootViewController = MainTabBarController()
        }
    }
    
    static func getFormController(
        withDelegate delegate: FormViewControllerDelegate
    ) -> UIViewController {
        let viewModel = FormViewModel()
        return FormViewController(delegate: delegate, viewModel: viewModel)
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
    
    static func getEditorViewController(
        withDelegate delegate: EditorViewControllerDelegate,
        andPlayer player: Player? = nil,
        tournament: Tournament? = nil
    ) -> UIViewController {
        let viewModel = EditorViewModel(player: player, tournament: tournament)
        let viewController = EditorViewController(
            delegate: delegate,
            viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    static func getTransferDetailsViewController(
        withDelegate delegate: TransferDetailsViewControllerDelegate
    ) -> UIViewController {
        TransferDetailsViewController(delegate: delegate)
    }
    
    static func getTestingDetailsViewController(
        withDelegate delegate: TestingDetailsViewControllerDelegate
    ) -> UIViewController {
        TestingDetailsViewController(delegate: delegate)
    }
    
    static func getPlayerViewController(
        withDelegate delegate: PlayerViewControllerDelegate,
        andViewModel viewModel: PlayerViewModel
    ) -> UIViewController {
        PlayerViewController(delegate: delegate, viewModel: viewModel)
    }
    
    static func getAddCareerViewController(
        withDelegate delegate: AddCareerViewControllerDelegate,
        andPlayer player: Player
    ) -> UIViewController {
        let viewModel = AddCareerViewModel(player: player)
        return AddCareerViewController(delegate: delegate, viewModel: viewModel)
    }
    
    static func getFiltersViewController(
        withDelegate delegate: FiltersViewControllerDelegate,
        andFiltersValue filtersValue: Bool
    ) -> UIViewController {
        let viewModel = FiltersViewModel(isFiltersActive: filtersValue)
        return FiltersViewController(delegate: delegate, viewModel: viewModel)
    }
    
    static func getPopoverViewController() -> UIViewController {
        let viewModel = PopoverViewModel()
        let popoverVC = PopoverViewController(viewModel: viewModel)
        popoverVC.modalPresentationStyle = .popover
        return popoverVC
    }
    
    static func getViewingPlanViewController() -> UIViewController {
        let viewModel = ViewingPlanViewModel()
        return ViewingPlanViewController(viewModel: viewModel)
    }
    
    static func getAddTournamentViewController(
        withDelegate delegate: AddTournamentViewControllerDelegate
    ) -> UIViewController {
        let viewModel = AddTournamentViewModel()
        return AddTournamentViewController(
            viewModel: viewModel,
            delegate: delegate)
    }
    
    static func getTournamentViewController(
        withDelegate delegate: TournamentViewControllerDelegate,
        andTournament tournament: Tournament
    ) -> UIViewController {
        let viewModel = TournamentViewModel(tournament: tournament)
        let tournamentVC = TournamentViewController(viewModel: viewModel)
        tournamentVC.delegate = delegate
        return UINavigationController(rootViewController: tournamentVC)
    }
    
    static func getResponsibleListViewController(
        andTournament tournament: Tournament
    ) -> UIViewController {
        let viewModel = ResponsibleListViewModel(tournament: tournament)
        let responsibleListVC = ResponsibleListViewController(
            viewModel: viewModel)
        responsibleListVC.modalPresentationStyle = .popover
        return responsibleListVC
    }
}
