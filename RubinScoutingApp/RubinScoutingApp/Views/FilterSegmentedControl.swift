//
//  FilterSegmentedControl.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class FilterSegmentedControl: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectedSegmentIndex = 0
        backgroundColor = .lightGray
    }
}
