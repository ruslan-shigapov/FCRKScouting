//
//  TournamentViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 25.09.2024.
//

import UIKit

final class TournamentViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: TournamentViewModelProtocol

    // MARK: Views
    private lazy var nameLabel: UILabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: viewModel.name,
            numberOfLines: 2,
            color: .rubin)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var deleteTournamentButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.delete)
        button.addTarget(
            self,
            action: #selector(deleteTournamentButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.age)
    private let dateLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.tournamentDate)
    private let placeLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.tournamentPlace)
    
    private lazy var ageValueLabel = DefaultTextLabel(text: viewModel.age)
    private lazy var dateValueLabel = DefaultTextLabel(text: viewModel.date)
    private lazy var placeValueLabel = DefaultTextLabel(text: viewModel.place)
    
    private let trophyImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Images.trophy)
        imageView.tintColor = .naturalGold
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.addSubviews(
            nameLabel,
            ageLabel,
            ageValueLabel,
            dateLabel,
            dateValueLabel,
            placeLabel,
            placeValueLabel,
            trophyImageView)
        view.prepareForAutoLayout()
        view.setupCornerRadius()
        view.setupBorder(withColor: .lightGray)
        return view
    }()
    
    private let responsibleOnesLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.responsibleOnes)
    
    private lazy var deletingModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.tintColor = .rubin
        button.setImage(
            Constants.Images.ButtonImages.deletingMode,
            for: .normal)
        button.setupCornerRadius()
        button.setupHighlightAnimation()
//        button.addTarget(
//            self,
//            action: #selector(deletingModeButtonTapped),
//            for: .touchUpInside)
        return button
    }()
    
    private lazy var popoverButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.backgroundColor = .lightGray
        button.tintColor = .rubin
        button.setupCornerRadius()
        button.setupHighlightAnimation()
//        button.addTarget(
//            self,
//            action: #selector(popoverButtonTapped),
//            for: .touchUpInside)
        return button
    }()
    
    private lazy var responsibleOneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.setupCornerRadius()
        collectionView.setupBorder(withColor: .lightGray)
        return collectionView
    }()
    
    private let playersForViewingLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.playersForViewing)
    
    private lazy var addPlayerButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.backgroundColor = .lightGray
        button.tintColor = .rubin
        button.setupCornerRadius()
        button.setupHighlightAnimation()
        button.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var playerForViewingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PlayerCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: PlayerCollectionViewCell.self))
        return collectionView
    }()
    
    private lazy var sendTaskButton = PrimaryButton(title: "Отправить задачу")
    
    // MARK: Public Properties
    weak var delegate: TournamentViewControllerDelegate?
    
    // MARK: Initialize
    init(viewModel: TournamentViewModelProtocol) {
        self.viewModel = viewModel
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
        setupContent()
        handleEvents()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .deepGreen
        view.addSubviews(
            nameLabel,
            deleteTournamentButton,
            backView,
            responsibleOnesLabel,
            deletingModeButton,
            popoverButton,
            responsibleOneCollectionView,
            playersForViewingLabel,
            addPlayerButton,
            playerForViewingCollectionView,
            sendTaskButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleEvents() {
        viewModel.playersWereChanged = { [weak self] in
            guard let self else { return }
            setupContent()
        }
        viewModel.backButtonWasTapped = { [weak self] in
            guard let self else { return }
            setupContent()
        }
    }
    
    private func setupContent() {
        viewModel.fetchPlayersForViewing { [weak self] in
            guard let self else { return }
            sendTaskButton.isHidden = viewModel.isPlayersForViewingEmpty
            playerForViewingCollectionView.reloadData()
        }
    }
    
    @objc private func deleteTournamentButtonTapped() {
        let alertController = AlertFactory.getConfirmationAlert(
            withTitle: Constants.Texts.Alerts.deleteTournament.title,
            andMessage: Constants.Texts.Alerts.deleteTournament.message
        ) { [weak self] in
            guard let self else { return }
            viewModel.deleteTournament() {
                self.dismiss(animated: true) {
                    self.delegate?.tournamentWasDeleted?()
                }
            }
        }
        present(alertController, animated: true)
    }
    
    @objc private func addPlayerButtonTapped() {
        let playerAddingVC = ScreenFactory.getEditorViewController(
            withDelegate: viewModel as EditorViewControllerDelegate,
            andPlayer: nil,
            tournament: viewModel.getTournament())
        present(playerAddingVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TournamentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 32, height: 90)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let currentPlayer = viewModel.getPlayer(at: indexPath) else {
            return
        }
        let playerVC = ScreenFactory.getPlayerViewController(
            withDelegate: viewModel as PlayerViewControllerDelegate,
            andPlayer: currentPlayer)
        navigationController?.pushViewController(playerVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension TournamentViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: PlayerCollectionViewCell.self),
            for: indexPath) as? PlayerCollectionViewCell
        cell?.viewModel = viewModel.getPlayerCellViewModel(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Layout
extension TournamentViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            nameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            nameLabel.trailingAnchor.constraint(
                equalTo: deleteTournamentButton.leadingAnchor,
                constant: -12),
            
            deleteTournamentButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 16),
            deleteTournamentButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            backView.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 20),
            backView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            backView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            ageLabel.topAnchor.constraint(
                equalTo: backView.topAnchor,
                constant: 12),
            ageLabel.leadingAnchor.constraint(
                equalTo: backView.leadingAnchor,
                constant: 12),
            
            ageValueLabel.leadingAnchor.constraint(
                equalTo: ageLabel.trailingAnchor,
                constant: 16),
            ageValueLabel.centerYAnchor.constraint(
                equalTo: ageLabel.centerYAnchor,
                constant: -1),
            
            dateLabel.topAnchor.constraint(
                equalTo: ageLabel.bottomAnchor,
                constant: 20),
            dateLabel.leadingAnchor.constraint(
                equalTo: backView.leadingAnchor,
                constant: 12),
            
            dateValueLabel.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor,
                constant: 8),
            dateValueLabel.leadingAnchor.constraint(
                equalTo: backView.leadingAnchor,
                constant: 12),
            
            placeLabel.topAnchor.constraint(
                equalTo: dateValueLabel.bottomAnchor,
                constant: 20),
            placeLabel.leadingAnchor.constraint(
                equalTo: backView.leadingAnchor,
                constant: 12),
            
            placeValueLabel.topAnchor.constraint(
                equalTo: placeLabel.bottomAnchor,
                constant: 8),
            placeValueLabel.leadingAnchor.constraint(
                equalTo: backView.leadingAnchor,
                constant: 12),
            placeValueLabel.bottomAnchor.constraint(
                equalTo: backView.bottomAnchor,
                constant: -12),
            
            trophyImageView.topAnchor.constraint(equalTo: ageLabel.topAnchor),
            trophyImageView.bottomAnchor.constraint(
                equalTo: placeLabel.bottomAnchor),
            trophyImageView.trailingAnchor.constraint(
                equalTo: backView.trailingAnchor,
                constant: -12),
            trophyImageView.widthAnchor.constraint(equalToConstant: 120),
            
            responsibleOnesLabel.topAnchor.constraint(
                equalTo: backView.bottomAnchor,
                constant: 24),
            responsibleOnesLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            deletingModeButton.trailingAnchor.constraint(
                equalTo: popoverButton.leadingAnchor,
                constant: -12),
            deletingModeButton.centerYAnchor.constraint(
                equalTo: responsibleOnesLabel.centerYAnchor,
                constant: -4),
            deletingModeButton.widthAnchor.constraint(equalToConstant: 50),
                
            popoverButton.trailingAnchor.constraint(
                equalTo: backView.trailingAnchor,
                constant: -12),
            popoverButton.centerYAnchor.constraint(
                equalTo: responsibleOnesLabel.centerYAnchor,
                constant: -4),
            popoverButton.widthAnchor.constraint(equalToConstant: 50),
            
            responsibleOneCollectionView.topAnchor.constraint(
                equalTo: responsibleOnesLabel.bottomAnchor,
                constant: 8),
            responsibleOneCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            responsibleOneCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            responsibleOneCollectionView.heightAnchor.constraint(
                equalToConstant: 70),
            
            playersForViewingLabel.topAnchor.constraint(
                equalTo: responsibleOneCollectionView.bottomAnchor,
                constant: 24),
            playersForViewingLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            addPlayerButton.trailingAnchor.constraint(
                equalTo: backView.trailingAnchor,
                constant: -12),
            addPlayerButton.centerYAnchor.constraint(
                equalTo: playersForViewingLabel.centerYAnchor,
                constant: -4),
            addPlayerButton.widthAnchor.constraint(equalToConstant: 50),
            
            playerForViewingCollectionView.topAnchor.constraint(
                equalTo: playersForViewingLabel.bottomAnchor,
                constant: 8),
            playerForViewingCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playerForViewingCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -85),
            playerForViewingCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            sendTaskButton.topAnchor.constraint(
                equalTo: playerForViewingCollectionView.bottomAnchor,
                constant: 8),
            sendTaskButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            sendTaskButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            sendTaskButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
