//
//  PlayerExtraCard.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class PlayerExtraCard: UIView {

    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: "Дополнительная информация",
            numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    
    private let actualTestLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.normal,
            text: "Актуальные результаты тестов")
        label.textAlignment = .center
        return label
    }()
    
    private let pageControl: DisabledPageControl = {
        let pageControl = DisabledPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 2
        return pageControl
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupCornerRadius()
        view.setupBorder()
        view.addSubviews(titleLabel, actualTestLabel, pageControl)
        view.prepareForAutoLayout()
        return view
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension PlayerExtraCard {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            
            titleLabel.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 24),
            titleLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            titleLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            
            actualTestLabel.centerYAnchor.constraint(
                equalTo: backgroundView.centerYAnchor),
            actualTestLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            
            pageControl.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -12)
        ])
    }
}
