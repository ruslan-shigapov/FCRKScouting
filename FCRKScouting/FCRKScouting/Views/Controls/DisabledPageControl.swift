//
//  DisabledPageControl.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class DisabledPageControl: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isEnabled = false
        currentPageIndicatorTintColor = .white
        pageIndicatorTintColor = .black.withAlphaComponent(0.7)
    }
}
