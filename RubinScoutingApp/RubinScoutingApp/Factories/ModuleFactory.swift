//
//  ModuleFactory.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class ModuleFactory {
    
    static let shared = ModuleFactory()
    
    private init() {}
    
    func getLoginVC() -> UIViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
    
    func getMainVC(forUser user: User) -> UIViewController {
        let viewModel = MainViewModel(user: user)
        return MainViewController(viewModel: viewModel)
    }
}
