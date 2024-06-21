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
    
    private let photoImageView = PhotoImageView()
    
    private lazy var fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: viewModel.fullName)
    
    private lazy var positionLabel = DefaultTextLabel(
        text: viewModel.position)
    
    private lazy var birthDateLabel = DefaultTextLabel(
        text: viewModel.birthDate)
    
    private let citizenshipLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: "Гражданство:")
    
    private let clubAndNationalTeamLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: "Клуб/сборная:")
    
    private let footLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: "Рабочая нога:")
    
    private let generalInfoLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.generalInfo)
    
    private lazy var citizenshipValueLabel = DefaultTextLabel(
        text: viewModel.citizenship)
    private lazy var clubAndNationalTeamValueLabel = DefaultTextLabel(
        text: viewModel.clubAndNationalTeam)
    private lazy var footValueLabel = DefaultTextLabel(
        text: viewModel.foot)
    
    private lazy var generalInfoValueLabel = DefaultTextLabel(
        text: viewModel.generalInfo)
    
    private lazy var creatorLabel = DefaultTextLabel(
        text: viewModel.creator)
    private lazy var lastEditorLabel = DefaultTextLabel(
        text: viewModel.lastEditor)
    
    private lazy var showStatisticsDetailsButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.statistics,
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
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setCommonCornerRadius()
        view.addSubviews(
            photoImageView,
            fullNameLabel,
            positionLabel,
            birthDateLabel,
            citizenshipLabel,
            clubAndNationalTeamLabel,
            footLabel,
            citizenshipValueLabel,
            clubAndNationalTeamValueLabel,
            footValueLabel,
            generalInfoLabel,
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
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        fullNameLabel.textColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
        photoImageView.image = UIImage(named: "image1")
        photoImageView.clipsToBounds = true
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1.0).cgColor
        positionLabel.numberOfLines = 2
        positionLabel.textColor = .white
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1.0).cgColor
        birthDateLabel.textColor = .white
        citizenshipValueLabel.textColor = .white
        clubAndNationalTeamValueLabel.textColor = .white
        footValueLabel.textColor = .white
        generalInfoValueLabel.numberOfLines = 0
        generalInfoValueLabel.textColor = .white
        lastEditorLabel.textAlignment = .center
        creatorLabel.textAlignment = .center
//        citizenshipLabel.textColor = .accent
//        clubAndNationalTeamLabel.textColor = .accent
//        footLabel.textColor = .accent
//        generalInfoLabel.textColor = .accent
        view.backgroundColor = .accent
        view.addSubview(backgroundView)
        view.prepareForAutoLayout()
        setConstraints()
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
        navigationItem.leftBarButtonItem = backButton
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(customView: editPlayerButton),
                UIBarButtonItem(customView: deletePlayerButton)
            ]
        }
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
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        delegate.backButtonWasTapped?()
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
                constant: -24),
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
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            fullNameLabel.topAnchor.constraint(
                equalTo: photoImageView.topAnchor, constant: 8),
            
            positionLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            positionLabel.topAnchor.constraint(
                equalTo: fullNameLabel.bottomAnchor,
                constant: 2),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            birthDateLabel.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor, constant: 1),
            
            citizenshipLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            citizenshipLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            
            clubAndNationalTeamLabel.topAnchor.constraint(equalTo: citizenshipLabel.bottomAnchor, constant: 16),
            clubAndNationalTeamLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            
            footLabel.topAnchor.constraint(equalTo: clubAndNationalTeamLabel.bottomAnchor, constant: 16),
            footLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            
            citizenshipValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            citizenshipValueLabel.centerYAnchor.constraint(
                equalTo: citizenshipLabel.centerYAnchor, constant: -1),
            
            clubAndNationalTeamValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            clubAndNationalTeamValueLabel.centerYAnchor.constraint(
                equalTo: clubAndNationalTeamLabel.centerYAnchor, constant: -1),
            
            footValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.leadingAnchor),
            footValueLabel.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor, constant: -1),
            
            generalInfoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            generalInfoLabel.topAnchor.constraint(equalTo: footLabel.bottomAnchor, constant: 32),
            
            generalInfoValueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            generalInfoValueLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            generalInfoValueLabel.topAnchor.constraint(equalTo: generalInfoLabel.bottomAnchor, constant: 4),
            
            lastEditorLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            lastEditorLabel.bottomAnchor.constraint(equalTo: showStatisticsDetailsButton.topAnchor, constant: -24),
            
            creatorLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            creatorLabel.bottomAnchor.constraint(equalTo: lastEditorLabel.topAnchor, constant: -6),
            
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
