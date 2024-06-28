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
    
    // MARK: Navigation Bar Buttons
    private lazy var editPlayerButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.edit)
        button.addTarget(
            self,
            action: #selector(editPlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var deletePlayerButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.delete)
        button.addTarget(
            self,
            action: #selector(deletePlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Labels
    private lazy var fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2)
    
    private let ageLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: "Возраст:")
    private let citizenshipLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.citizenship)
    private let clubAndNationalTeamLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.clubAndNationalTeam)
    private let footLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.foot)
    private let generalInfoLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.generalInfo)
    
    private lazy var positionValueLabel: UILabel = {
        let label = DefaultTextLabel()
        label.numberOfLines = 2
        return label
    }()
    private lazy var ageValueLabel = DefaultTextLabel()
    private lazy var citizenshipValueLabel = DefaultTextLabel()
    private lazy var clubAndNationalTeamValueLabel: UILabel = {
        let label = DefaultTextLabel()
        label.numberOfLines = 2
        return label
    }()
    private lazy var footValueLabel = DefaultTextLabel()
    private lazy var generalInfoValueLabel: UILabel = {
        let label = DefaultTextLabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var creatorLabel = DefaultTextLabel(text: viewModel.creator)
    private lazy var lastEditorLabel = DefaultTextLabel()

    // MARK: Buttons
    private lazy var showStatisticsDetailsButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.statisticsDetails,
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showStatisticsDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var showTestingDetailsButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.testingDetails,
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showTestingDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Views
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
    
    private let photoImageView = PhotoImageView()
    
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
            generalInfoLabel,
            ageValueLabel,
            citizenshipValueLabel,
            clubAndNationalTeamValueLabel,
            footValueLabel,
            generalInfoValueLabel,
            creatorLabel,
            lastEditorLabel,
            showStatisticsDetailsButton,
            showTestingDetailsButton)
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
        handlePlayerEditing()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .accent
        view.addSubview(backgroundView)
        view.prepareForAutoLayout()
        setConstraints()
        configureUI()
    }
    
    private func configureUI() {
        if let photo = viewModel.photo {
            photoImageView.image = photo
        } else {
            photoImageView.image = Constants.Images.photoPlaceholder
        }
        fullNameLabel.text = viewModel.fullName
        positionValueLabel.text = viewModel.position
        ageValueLabel.text = viewModel.birthDate
        citizenshipValueLabel.text = viewModel.citizenship
        clubAndNationalTeamValueLabel.text = viewModel.clubAndNationalTeam
        footValueLabel.text = viewModel.foot
        generalInfoValueLabel.text = viewModel.generalInfo
        lastEditorLabel.text = viewModel.lastEditor
        // добавить всю ост инфу, попытаться вместить
        // подумать над кнопками, которые детальные, как реализовать переходы
        // сюда же, придумать, как добавить футбольную вертикаль
        // разобраться со сменой имени
    }
    
    private func handlePlayerEditing() {
        viewModel.playersWereChanged = { [weak self] in
            guard let self else { return }
            configureUI()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem(
            title: Constants.Text.ButtonTitles.back,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        backButton.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .normal)
        backButton.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .highlighted)
        navigationItem.leftBarButtonItem = backButton
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(customView: editPlayerButton),
                UIBarButtonItem(customView: deletePlayerButton)
            ]
        }
    }
    
    // MARK: Selectors
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
    
    @objc private func showStatisticsDetailsButtonTapped() {
        let statisticsDetailsVC = ScreenFactory.getStatisticsDetailsVC()
        present(statisticsDetailsVC, animated: true)
    }
    
    @objc private func showTestingDetailsButtonTapped() {
        let testingDetailsVC = ScreenFactory.getTestingDetailsVC()
        present(testingDetailsVC, animated: true)
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
            
            footLabel.topAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.bottomAnchor,
                constant: 16),
            footLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
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
            
            generalInfoLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            generalInfoLabel.topAnchor.constraint(
                equalTo: footLabel.bottomAnchor,
                constant: 32),
            
            generalInfoValueLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            generalInfoValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            generalInfoValueLabel.topAnchor.constraint(
                equalTo: generalInfoLabel.bottomAnchor,
                constant: 4),
            
            lastEditorLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            lastEditorLabel.bottomAnchor.constraint(
                equalTo: showStatisticsDetailsButton.topAnchor,
                constant: -16),
            
            creatorLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            creatorLabel.bottomAnchor.constraint(
                equalTo: lastEditorLabel.topAnchor,
                constant: -4),
            
            showStatisticsDetailsButton.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            showStatisticsDetailsButton.bottomAnchor.constraint(
                equalTo: showTestingDetailsButton.topAnchor,
                constant: -16),
            showStatisticsDetailsButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            
            showTestingDetailsButton.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            showTestingDetailsButton.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24),
            showTestingDetailsButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
        ])
    }
}
