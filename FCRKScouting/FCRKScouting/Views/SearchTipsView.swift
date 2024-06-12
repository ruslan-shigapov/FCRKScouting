//
//  SearchTipsView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class SearchTipsView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.text
        label.text = Constants.Text.Tips.title
        label.textColor = .white
        return label
    }()
    
    private let featuresStackView = TipStackView(
        image: Constants.Images.ButtonImages.features,
        text: Constants.Text.Tips.features)
    private let relatedStackView = TipStackView(
        image: Constants.Images.ButtonImages.related,
        text: Constants.Text.Tips.related)
    private let filtersStackView = TipStackView(
        image: Constants.Images.ButtonImages.filters,
        text: Constants.Text.Tips.filters)
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                featuresStackView,
                relatedStackView,
                filtersStackView
            ])
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension SearchTipsView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
}
