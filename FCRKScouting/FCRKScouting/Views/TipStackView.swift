//
//  TipStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class TipStackView: UIStackView {
        
    private let imageView: UIImageView = {
        $0.tintColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 28).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return $0
    }(UIImageView())
    
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
        addArrangedSubview(imageView)
        addArrangedSubview(titleLabel)
        spacing = 2
    }
}
