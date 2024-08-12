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
        tabBar.backgroundColor = .rubin
        tabBar.barTintColor = .rubin
        tabBar.tintColor = .white
    }
    
    private func setViewControllers() {
        viewControllers = [
            generateNavigationFlow(
                forViewController: ScreenFactory.getUpdatesViewController(),
                withTitle: Constants.Text.ScreenTitles.updates,
                andTabBarIcon: Constants.Images.TabBarIcons.updates),
            generateNavigationFlow(
                forViewController: ScreenFactory.getSearchViewController(),
                withTitle: Constants.Text.ScreenTitles.search,
                andTabBarIcon: Constants.Images.TabBarIcons.search),
            generateNavigationFlow(
                forViewController: ScreenFactory.getProfileViewController(),
                withTitle: Constants.Text.ScreenTitles.profile,
                andTabBarIcon: Constants.Images.TabBarIcons.profile)
        ]
    }
    
    private func generateNavigationFlow(
        forViewController viewController: UIViewController,
        withTitle title: String,
        andTabBarIcon icon: UIImage?
    ) -> UINavigationController {
        viewController.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = icon
        let navigationController = UINavigationController(
            rootViewController: viewController)
        setupNavigationBar(forNavigationController: navigationController)
        return navigationController
    }
    
    private func setupNavigationBar(
        forNavigationController navigationController: UINavigationController
    ) {
        let navigationBar = navigationController.navigationBar
        navigationBar.scrollEdgeAppearance = getNavigationBarAppearance()
    }
    
    private func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .rubin
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.titlePositionAdjustment = UIOffset(
            horizontal: -UIScreen.main.bounds.width / 2,
            vertical: 6)
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Constants.Fonts.title as Any,
        ]
        return navigationBarAppearance
    }
}
