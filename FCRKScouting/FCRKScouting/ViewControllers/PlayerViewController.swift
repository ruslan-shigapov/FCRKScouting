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
 
    private lazy var editPlayerButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.edit)
        button.addTarget(
            self,
            action: #selector(editPlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var deletePlayerButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.delete)
        button.addTarget(
            self,
            action: #selector(deletePlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var playerMainCard: PlayerMainCard = {
        let playerCard = PlayerMainCard()
        playerCard.viewModel = viewModel.getMainPlayerCardViewModel()
        return playerCard
    }()
    private lazy var playerCareerCard: PlayerCareerCard = {
        let playerCard = PlayerCareerCard()
        return playerCard
    }()
    private lazy var playerExtraCard: PlayerExtraCard = {
        let playerCard = PlayerExtraCard()
        return playerCard
    }()
    
    private lazy var cardSliderView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
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
        generateScrollView(
            withPages: [playerMainCard, playerCareerCard, playerExtraCard])
        view.backgroundColor = .accent
        view.addSubview(cardSliderView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handlePlayerEditing() {
        viewModel.playersWereChanged = { /*[weak self] in*/
//            guard let self else { return }
//            configureUI() TODO: Send by delegate
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
    
    private func generateScrollView(withPages pages: [UIView]) {
        cardSliderView.contentSize = CGSize(
            width: view.frame.width * CGFloat(pages.count),
            height: cardSliderView.frame.height
        )
        for (index, page) in pages.enumerated() {
            page.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height * 0.76)
            cardSliderView.addSubview(page)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        delegate.backButtonWasTapped?()
    }
    
    @objc private func editPlayerButtonTapped() {
        let playerEditingVC = ScreenFactory.getEditorViewController(
            withDelegate: viewModel as EditorViewControllerDelegate, 
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
            self.navigationController?.popViewController(animated: true)
            self.delegate.backButtonWasTapped?()
        }
        present(alertController, animated: true)
    }
}

// MARK: - Layout
private extension PlayerViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cardSliderView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            cardSliderView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            cardSliderView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            cardSliderView.heightAnchor.constraint(
                equalToConstant: view.frame.height * 0.76)
        ])
    }
}
