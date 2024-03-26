//
//  MainTabBarController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 16.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setVCs()
    }
    
    private func setVCs() {
        viewControllers = [
            generateNavigationFlowFor(
                viewController: UpdatesViewController(),
                withTitle: Constants.Text.ScreenTitle.updates,
                andTabBarIcon: Constants.Images.TabBarIcon.updates),
            generateNavigationFlowFor(
                viewController: SearchViewController(),
                withTitle: Constants.Text.ScreenTitle.search,
                andTabBarIcon: Constants.Images.TabBarIcon.search),
            generateNavigationFlowFor(
                viewController: MainViewController(viewModel: viewModel),
                withTitle: Constants.Text.ScreenTitle.profile,
                andTabBarIcon: Constants.Images.TabBarIcon.profile)
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
        return UINavigationController(rootViewController: viewController)
    }
}
