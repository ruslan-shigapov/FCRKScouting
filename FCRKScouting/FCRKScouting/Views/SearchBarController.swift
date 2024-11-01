//
//  SearchBarController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.10.2024.
//

import UIKit

final class SearchBarController: UISearchController {
            
    init() {
        super.init(searchResultsController: nil)
        obscuresBackgroundDuringPresentation = false
        setupSearchBar()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = Constants.Texts.Placeholders.startTyping
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
        searchBar.searchTextField.backgroundColor = .transparentWhite
    }
}
