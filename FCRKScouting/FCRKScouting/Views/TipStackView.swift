//
//  TipStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class TipStackView: UIStackView {
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imageView
    }()
    
    private let titleLabel = DefaultTextLabel()

    init(image: UIImage?, text: String) {
        imageView.image = image
        titleLabel.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        spacing = 2
        addArrangedSubview(imageView)
        addArrangedSubview(titleLabel)
    }
}
