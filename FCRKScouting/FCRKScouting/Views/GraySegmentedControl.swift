//
//  GraySegmentedControl.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class GraySegmentedControl: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .lightGray
        selectedSegmentIndex = 0
    }
}
