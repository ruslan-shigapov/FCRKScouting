//
//  MainTabBarController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 16.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setViewControllers()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        tabBar.backgroundColor = .accent
        tabBar.barTintColor = .accent
        tabBar.tintColor = .white
    }
    
    private func setViewControllers() {
        viewControllers = [
            generateNavigationFlowFor(
                viewController: ScreenFactory.getUpdatesViewController(),
                withTitle: Constants.Text.ScreenTitles.updates,
                andTabBarIcon: Constants.Images.TabBarIcons.updates
            ),
            generateNavigationFlowFor(
                viewController: ScreenFactory.getSearchViewController(),
                withTitle: Constants.Text.ScreenTitles.search,
                andTabBarIcon: Constants.Images.TabBarIcons.search
            ),
            generateNavigationFlowFor(
                viewController: ScreenFactory.getProfileViewController(),
                withTitle: Constants.Text.ScreenTitles.profile,
                andTabBarIcon: Constants.Images.TabBarIcons.profile
            )
        ]
    }
    
    private func generateNavigationFlowFor(
        viewController: UIViewController,
        withTitle title: String,
        andTabBarIcon icon: UIImage?
    ) -> UINavigationController {
        viewController.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = icon
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        setupNavigationBarFor(navigationController)
        return navigationController
    }
    
    private func setupNavigationBarFor(
        _ navigationController: UINavigationController
    ) {
        let navigationBar = navigationController.navigationBar
        navigationBar.scrollEdgeAppearance = setupScrollEdgeAppearance()
        // TODO: или вовсе удалить, или настроить
//        navigationBar.standardAppearance = setupStandardAppearance()
    }
    
    private func setupScrollEdgeAppearance() -> UINavigationBarAppearance {
        let navigationBarScrollEdgeAppearance = UINavigationBarAppearance()
        navigationBarScrollEdgeAppearance.backgroundColor = .accent
        navigationBarScrollEdgeAppearance.shadowColor = .clear
        navigationBarScrollEdgeAppearance.titlePositionAdjustment = UIOffset(
            horizontal: -UIScreen.main.bounds.width / 2,
            vertical: 6
        )
        navigationBarScrollEdgeAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Constants.Fonts.title as Any,
        ]
        return navigationBarScrollEdgeAppearance
    }
    
//    private func setupStandardAppearance() -> UINavigationBarAppearance {
//        let navigationBarStandardAppearance = UINavigationBarAppearance()
//        let translucentColor = UIColor.accent.withAlphaComponent(0.9)
//        navigationBarStandardAppearance.backgroundColor = translucentColor
//        navigationBarStandardAppearance.titleTextAttributes = [
//            .foregroundColor: UIColor.clear
//        ]
//        return navigationBarStandardAppearance
//    }
}
