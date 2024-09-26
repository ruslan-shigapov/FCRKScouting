//
//  ViewingPlanViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 23.09.2024.
//

import UIKit

final class ViewingPlanViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: ViewingPlanViewModelProtocol
    
    // MARK: Views
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: Constants.Texts.ButtonTitles.back,
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
    
    private lazy var addTournamentButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.add)
        button.addTarget(
            self,
            action: #selector(addTournamentButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Texts.ScreenTitles.viewingPlan,
            numberOfLines: 2,
            color: .systemGreen)
        label.textAlignment = .center
        return label
    }()
    
    private let noTournamentsLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(
            text: Constants.Texts.noTournaments,
            numberOfLines: 2)
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var tournamentCollectionView: VerticalCollectionView = {
        let collectionView = VerticalCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            TournamentCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: TournamentCollectionViewCell.self))
        return collectionView
    }()
    
    // MARK: Initialize
    init(viewModel: ViewingPlanViewModelProtocol) {
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
        setupNavigationBar()
        view.backgroundColor = .rubin
        view.addSubviews(
            titleLabel,
            noTournamentsLabel,
            tournamentCollectionView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(customView: addTournamentButton)
            ]
        }
    }
    
    private func handleEvents() {
        viewModel.tournamentWasAdded = { [weak self] in
            guard let self else { return }
            setupContent()
        }
        viewModel.tournamentWasDeleted = { [weak self] in
            guard let self else { return }
            setupContent()
        }
    }
    
    private func setupContent() {
        viewModel.fetchTournaments { [weak self] in
            guard let self else { return }
            noTournamentsLabel.isHidden = !viewModel.hasNoTournaments
            tournamentCollectionView.reloadData()
        }
    }
        
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addTournamentButtonTapped() {
        let addTournamentVC = ScreenFactory.getAddTournamentViewController(
            withDelegate: viewModel as AddTournamentViewControllerDelegate)
        if let sheet = addTournamentVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(addTournamentVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewingPlanViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 32, height: 72)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == (collectionView.numberOfSections - 1) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        } else {
            return UIEdgeInsets.zero
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewingPlanViewController: UICollectionViewDataSource {
    
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
                describing: TournamentCollectionViewCell.self),
            for: indexPath) as? TournamentCollectionViewCell
        cell?.viewModel = viewModel.getTournamentCellViewModel(
            at: indexPath.item)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let tournamentVC = ScreenFactory.getTournamentViewController(
            withDelegate: viewModel as TournamentViewControllerDelegate,
            andTournament: viewModel.getTournament(at: indexPath.item))
        present(tournamentVC, animated: true)
    }
}

// MARK: - Layout
extension ViewingPlanViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            noTournamentsLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            noTournamentsLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            noTournamentsLabel.widthAnchor.constraint(equalToConstant: 190),
            
            tournamentCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 16),
            tournamentCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tournamentCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tournamentCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
