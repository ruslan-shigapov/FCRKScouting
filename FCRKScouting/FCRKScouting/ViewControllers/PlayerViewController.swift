//
//  PlayerViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: PlayerViewModelProtocol
    private var delegate: PlayerViewControllerDelegate
    
    // MARK: Views
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: Constants.Text.ButtonTitles.back,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        button.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .normal)
        button.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .highlighted)
        return button
    }()
 
    private lazy var editPlayerButton: UIButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.edit)
        button.addTarget(
            self,
            action: #selector(editPlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var deletePlayerButton: UIButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.delete)
        button.addTarget(
            self,
            action: #selector(deletePlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let photoImageView = PhotoImageView()
    
    private lazy var fullNameLabel = CustomLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2)
    
    private let positionValueLabel = DefaultTextLabel(numberOfLines: 2)
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameLabel,
                positionValueLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.age)
    private let citizenshipLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.citizenship)
    private let clubAndNationalTeamLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.clubAndNationalTeam)
    private let footLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.foot)
    private let heightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.height)
    private let weightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.weight)
    
    private let ageValueLabel = DefaultTextLabel()
    private let citizenshipValueLabel = DefaultTextLabel()
    private let clubAndNationalTeamValueLabel = DefaultTextLabel(
        numberOfLines: 2)
    private let footValueLabel = DefaultTextLabel()
    private let heightValueLabel = DefaultTextLabel()
    private let weightValueLabel = DefaultTextLabel()
    
    private let playerInfoScrollView = PlayerInfoScrollView()
    
    private lazy var creatorLabel = DefaultTextLabel(text: viewModel.creator)
    private let lastEditorLabel = DefaultTextLabel()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setCommonCornerRadius()
        view.setCommonBorder()
        view.addSubviews(
            photoImageView,
            titleStackView,
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
            lastEditorLabel)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Initialize
    init(
        viewModel: PlayerViewModelProtocol,
        delegate: PlayerViewControllerDelegate
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        handlePlayerEditing()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .accent
        view.addSubview(backgroundView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureUI() {
        if let photo = viewModel.photo {
            photoImageView.image = photo
        } else {
            photoImageView.image = Constants.Images.photoPlaceholder
        }
        fullNameLabel.text = viewModel.fullName
        positionValueLabel.text = viewModel.position
        ageValueLabel.text = viewModel.age
        citizenshipValueLabel.text = viewModel.citizenship
        clubAndNationalTeamValueLabel.text = viewModel.clubAndNationalTeam
        footValueLabel.text = viewModel.foot
        heightValueLabel.text = viewModel.height
        weightValueLabel.text = viewModel.weight
        playerInfoScrollView.configure(
            withGeneralInfoValue: viewModel.generalInfo,
            techniqueValue: viewModel.technique,
            tacticsValue: viewModel.tactics,
            qualitiesValue: viewModel.qualities,
            mentalValue: viewModel.mental)
        lastEditorLabel.text = viewModel.lastEditor
    }
    
    private func handlePlayerEditing() {
        viewModel.playersWereChanged = { [weak self] in
            guard let self else { return }
            configureUI()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(customView: editPlayerButton),
                UIBarButtonItem(customView: deletePlayerButton)
            ]
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        delegate.backButtonWasTapped?()
    }
    
    @objc private func editPlayerButtonTapped() {
        let playerEditingVC = ScreenFactory.getEditorViewControllerWith(
            delegate: viewModel as EditorViewControllerDelegate, 
            andPlayer: viewModel.getPlayer())
        present(playerEditingVC, animated: true)
    }
    
    @objc private func deletePlayerButtonTapped() {
        let alertController = AlertFactory.getConfirmationAlert(
            withTitle: Constants.Text.Alerts.delete.title,
            andMessage: Constants.Text.Alerts.delete.message
        ) { [weak self] in
            guard let self else { return }
            viewModel.deletePlayer()
            navigationController?.popViewController(animated: true)
            delegate.backButtonWasTapped?()
        }
        present(alertController, animated: true)
    }
}

// MARK: - Layout
private extension PlayerViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            backgroundView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            photoImageView.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 24),
            photoImageView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            titleStackView.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            titleStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            titleStackView.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor),
            
            ageLabel.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 24),
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
                equalTo: fullNameLabel.leadingAnchor),
            
            ageValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            ageValueLabel.centerYAnchor.constraint(
                equalTo: ageLabel.centerYAnchor,
                constant: -2),
            
            citizenshipValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            citizenshipValueLabel.centerYAnchor.constraint(
                equalTo: citizenshipLabel.centerYAnchor,
                constant: -2),
            
            clubAndNationalTeamValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            clubAndNationalTeamValueLabel.trailingAnchor.constraint(
                equalTo: fullNameLabel.trailingAnchor),
            clubAndNationalTeamValueLabel.centerYAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.centerYAnchor,
                constant: -2),
            
            footValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            footValueLabel.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -2),
            
            heightValueLabel.leadingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor,
                constant: 16),
            heightValueLabel.centerYAnchor.constraint(
                equalTo: heightLabel.centerYAnchor,
                constant: -2),
            
            weightValueLabel.leadingAnchor.constraint(
                equalTo: weightLabel.trailingAnchor,
                constant: 16),
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
                equalTo: backgroundView.bottomAnchor,
                constant: -24),
            
            creatorLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            creatorLabel.bottomAnchor.constraint(
                equalTo: lastEditorLabel.topAnchor,
                constant: -4)
        ])
    }
}
