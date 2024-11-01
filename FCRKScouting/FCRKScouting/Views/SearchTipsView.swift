//
//  SearchTipsView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class SearchTipsView: UIView {
    
    // MARK: Private Properties
    private let isFullSetRequired: Bool
    
    // MARK: Views
    private let titleLabel: DefaultTextLabel = {
        $0.textColor = .white
        return $0
    }(DefaultTextLabel(text: Constants.Texts.Tips.title))
    
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
        if isFullSetRequired {
            $0.insertArrangedSubview(relatedStackView, at: 2)
        }
        $0.axis = .vertical
        $0.spacing = 1
        return $0
    }(UIStackView(
        arrangedSubviews: [
            titleLabel,
            favoritesStackView,
            filtersStackView
        ]))
    
    // MARK: Initialize
    init(isFullSetRequired: Bool) {
        self.isFullSetRequired = isFullSetRequired
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubview(containerStackView)
        prepareForAutoLayout()
    }
}

// MARK: - Layout
private extension SearchTipsView {
    
    func setConstraints() {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
}
