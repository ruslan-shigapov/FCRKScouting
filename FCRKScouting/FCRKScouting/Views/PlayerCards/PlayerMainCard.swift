//
//  PlayerMainCard.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class PlayerMainCard: UIView {
    
    // MARK: Views
    private let photoImageView = PhotoImageView()
    
    private lazy var fullNameLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    
    private let positionValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameLabel,
                positionValueLabel
            ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var toggleFavoritesButton: FavoritesButton = {
        let button = FavoritesButton()
        button.addTarget(
            self,
            action: #selector(toggleFavoritesButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.age)
    private let citizenshipLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.citizenship)
    private let clubAndNationalTeamLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.clubAndNationalTeam)
    private let footLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.foot)
    private let heightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.height)
    private let weightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.weight)
    
    private let ageValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .center
        return label
    }()
    private let citizenshipValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .center
        return label
    }()
    private let clubAndNationalTeamValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    private let footValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .center
        return label
    }()
    private let heightValueLabel = DefaultTextLabel()
    private let weightValueLabel = DefaultTextLabel()
    
    private let playerInfoScrollView = PlayerInfoScrollView()
    
    private let creatorLabel = DefaultTextLabel()
    private let lastEditorLabel = DefaultTextLabel()
    
    private let pageControl: DisabledPageControl = {
        let pageControl = DisabledPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupCornerRadius()
        view.setupBorder()
        view.addSubviews(
            photoImageView,
            titleStackView,
            toggleFavoritesButton,
            ageLabel,
            citizenshipLabel,
            clubAndNationalTeamLabel,
            footLabel,
            heightLabel,
            weightLabel,
            ageValueLabel,
            citizenshipValueLabel,
            clubAndNationalTeamValueLabel,
            footValueLabel,
            heightValueLabel,
            weightValueLabel,
            playerInfoScrollView,
            creatorLabel,
            lastEditorLabel,
            pageControl)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Public Properties
    var viewModel: PlayerMainCardViewModelProtocol? {
        didSet {
            if let photo = viewModel?.photo {
                photoImageView.image = photo
            } else {
                photoImageView.image = Constants.Images.photoPlaceholder
            }
            fullNameLabel.text = viewModel?.fullName
            positionValueLabel.text = viewModel?.position
            ageValueLabel.text = viewModel?.age
            citizenshipValueLabel.text = viewModel?.citizenship
            clubAndNationalTeamValueLabel.text = viewModel?.clubAndNationalTeam
            footValueLabel.text = viewModel?.foot
            heightValueLabel.text = viewModel?.height
            weightValueLabel.text = viewModel?.weight
            playerInfoScrollView.configure(
                withGeneralInfoValue: viewModel?.generalInfo,
                techniqueValue: viewModel?.technique,
                tacticsValue: viewModel?.tactics,
                qualitiesValue: viewModel?.qualities,
                mentalValue: viewModel?.mental)
            creatorLabel.text = viewModel?.creator
            lastEditorLabel.text = viewModel?.lastEdition
            guard let viewModel else { return }
            toggleFavoritesButton.isSelected = viewModel.isFavorite
        }
    }

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
    
    @objc private func toggleFavoritesButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected
        ? viewModel?.addPlayerToFavorites()
        : viewModel?.removePlayerFromFavorites()
    }
}

// MARK: - Layout
private extension PlayerMainCard {
    
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
            
            photoImageView.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 16),
            photoImageView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 16),
            photoImageView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height * 0.15),
            photoImageView.widthAnchor.constraint(
                equalTo: photoImageView.heightAnchor),
            
            titleStackView.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 8),
            titleStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -8),
            titleStackView.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor, constant: 8),
            
            toggleFavoritesButton.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 8),
            toggleFavoritesButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -8),
            
            ageLabel.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 16),
            ageLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            citizenshipLabel.topAnchor.constraint(
                equalTo: ageLabel.bottomAnchor,
                constant: 16),
            citizenshipLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            clubAndNationalTeamLabel.topAnchor.constraint(
                equalTo: citizenshipLabel.bottomAnchor,
                constant: 16),
            clubAndNationalTeamLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            clubAndNationalTeamLabel.widthAnchor.constraint(
                equalToConstant: 135),
            
            footLabel.topAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.bottomAnchor,
                constant: 16),
            footLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            heightLabel.topAnchor.constraint(
                equalTo: footLabel.bottomAnchor,
                constant: 16),
            heightLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            weightLabel.topAnchor.constraint(
                equalTo: footLabel.bottomAnchor,
                constant: 16),
            weightLabel.leadingAnchor.constraint(
                equalTo: clubAndNationalTeamValueLabel.leadingAnchor),
            
            ageValueLabel.leadingAnchor.constraint(
                equalTo: clubAndNationalTeamValueLabel.leadingAnchor),
            ageValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16),
            ageValueLabel.centerYAnchor.constraint(
                equalTo: ageLabel.centerYAnchor,
                constant: -2),
            
            citizenshipValueLabel.leadingAnchor.constraint(
                equalTo: clubAndNationalTeamValueLabel.leadingAnchor),
            citizenshipValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16),
            citizenshipValueLabel.centerYAnchor.constraint(
                equalTo: citizenshipLabel.centerYAnchor,
                constant: -2),
            
            clubAndNationalTeamValueLabel.leadingAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.trailingAnchor,
                constant: 8),
            clubAndNationalTeamValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16),
            clubAndNationalTeamValueLabel.centerYAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.centerYAnchor,
                constant: -2),
            
            footValueLabel.leadingAnchor.constraint(
                equalTo: clubAndNationalTeamValueLabel.leadingAnchor),
            footValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16),
            footValueLabel.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -2),
            
            heightValueLabel.trailingAnchor.constraint(
                equalTo: footLabel.trailingAnchor,
                constant: -8),
            heightValueLabel.centerYAnchor.constraint(
                equalTo: heightLabel.centerYAnchor,
                constant: -2),
            
            weightValueLabel.centerXAnchor.constraint(
                equalTo: footValueLabel.centerXAnchor),
            weightValueLabel.centerYAnchor.constraint(
                equalTo: weightLabel.centerYAnchor,
                constant: -2),
            
            playerInfoScrollView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 18),
            playerInfoScrollView.topAnchor.constraint(
                equalTo: heightLabel.bottomAnchor,
                constant: 16),
            playerInfoScrollView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -18),
            playerInfoScrollView.bottomAnchor.constraint(
                equalTo: creatorLabel.topAnchor,
                constant: -16),
            
            lastEditorLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            lastEditorLabel.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor,
                constant: -8),
            
            creatorLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            creatorLabel.bottomAnchor.constraint(
                equalTo: lastEditorLabel.topAnchor,
                constant: -4),
            
            pageControl.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -12)
        ])
    }
}
