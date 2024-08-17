//
//  SearchTipsView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class SearchTipsView: UIView {
    
    // MARK: Private Properties
    private let isFullSet: Bool
    
    // MARK: Views
    private let titleLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(text: Constants.Texts.Tips.title)
        label.textColor = .white
        return label
    }()
    
    private let favoritesStackView = TipStackView(
        image: Constants.Images.ButtonImages.favorites,
        text: Constants.Texts.Tips.favorites)
    private let relatedStackView = TipStackView(
        image: Constants.Images.ButtonImages.related,
        text: Constants.Texts.Tips.related)
    private let filtersStackView = TipStackView(
        image: Constants.Images.ButtonImages.filters,
        text: Constants.Texts.Tips.filters)
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                favoritesStackView,
                filtersStackView
            ])
        if isFullSet {
            stackView.insertArrangedSubview(relatedStackView, at: 2)
        }
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    // MARK: Initialize
    init(isFullSet: Bool) {
        self.isFullSet = isFullSet
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
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
