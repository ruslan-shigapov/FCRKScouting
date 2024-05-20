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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.text
        label.text = text
        label.textColor = .lightGray
        return label
    }()

    init(image: UIImage?, text: String) {
        self.image = image
        self.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        spacing = 2
        addArrangedSubview(imageView)
        addArrangedSubview(descriptionLabel)
    }
}
