//
//  PhotoImageView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class PhotoImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            if image == Constants.Images.photoPlaceholder {
                layer.borderWidth = 0
            } else {
                setupBorder()
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
 
    private func setupUI() {
        image = Constants.Images.photoPlaceholder
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
}
