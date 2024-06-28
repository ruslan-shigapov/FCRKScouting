//
//  TipStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class TipStackView: UIStackView {
    
    private let image: UIImage?
    private let text: String
    
    private lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imageView
    }()
    
    private lazy var descriptionLabel = DefaultTextLabel(text: text)

    init(image: UIImage?, text: String) {
        self.image = image
        self.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        spacing = 2
        addArrangedSubview(customImageView)
        addArrangedSubview(descriptionLabel)
    }
}
