//
//  MainTabBarController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 16.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let viewModel: MainTabBarViewModelProtocol
    
    // MARK: Initialize
    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
                viewController: ScreenFactory.getUpdatesViewController(
                    forUser: viewModel.user),
                withTitle: Constants.Text.ScreenTitles.updates,
                andTabBarIcon: Constants.Images.TabBarIcons.updates),
            generateNavigationFlowFor(
                viewController: ScreenFactory.getSearchViewController(
                    forUser: viewModel.user), 
                withTitle: Constants.Text.ScreenTitles.search,
                andTabBarIcon: Constants.Images.TabBarIcons.search),
            generateNavigationFlowFor(
                viewController: ScreenFactory.getProfileViewController(
                    forUser: viewModel.user),
                withTitle: Constants.Text.ScreenTitles.profile,
                andTabBarIcon: Constants.Images.TabBarIcons.profile)
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
            rootViewController: viewController)
        setupNavigationBar(forNavigationController: navigationController)
        return navigationController
    }
    
    private func setupNavigationBar(
        forNavigationController navigationController: UINavigationController
    ) {
        let navigationBarScrollEdgeAppearance = UINavigationBarAppearance()
        navigationBarScrollEdgeAppearance.backgroundColor = .accent
        navigationBarScrollEdgeAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Constants.Fonts.title as Any
        ]
        navigationBarScrollEdgeAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        let navigationBar = navigationController.navigationBar
        navigationBar.prefersLargeTitles = true
        navigationBar.scrollEdgeAppearance = navigationBarScrollEdgeAppearance
        let navigationBarStandardAppearance = UINavigationBarAppearance()
        let translucentColor = UIColor.accent.withAlphaComponent(0.9)
        navigationBarStandardAppearance.backgroundColor = translucentColor
        navigationBarStandardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        navigationBar.standardAppearance = navigationBarStandardAppearance
    }
}
