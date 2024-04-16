//
//  PhotoImageView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class PhotoImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setupUI() {
        backgroundColor = .lightGray
        image = Constants.Images.photoPlaceholder
        tintColor = .accent
    }
}
