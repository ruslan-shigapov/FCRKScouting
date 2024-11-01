//
//  PlayerCareerCard.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class PlayerCareerCard: UIView {
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Texts.ScreenTitles.career,
            numberOfLines: 2,
            color: .rubin)
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.fullName)
    private let currentLeagueLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.currentLeague)
    private let careerLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.career)
    
    private let fullNameValueLabel = DefaultTextLabel()
    
    private lazy var popoverButton: UIButton = {
        let button = UIButton(
            configuration: getButtonConfiguration(
                with: viewModel?.currentLeague ?? ""),
            primaryAction: UIAction { _ in
                self.popoverButtonTapped()
        })
        button.tintColor = .white.withAlphaComponent(0.7)
        return button
    }()
    
    private lazy var addCareerButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.backgroundColor = .lightGray
        button.tintColor = .rubin
        button.setupCornerRadius()
        button.setupHighlightAnimation()
        button.addTarget(
            self,
            action: #selector(addCareerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var deletingModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.tintColor = .rubin 
        button.setImage(
            Constants.Images.ButtonImages.deletingMode,
            for: .normal)
        button.setupCornerRadius()
        button.setupHighlightAnimation()
        button.addTarget(
            self,
            action: #selector(deletingModeButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var careerTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(
            CareerTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: CareerTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var roundedContainerView: UIView = {
        let view = UIView()
        view.setupBorder(withColor: .lightGray)
        view.setupCornerRadius()
        view.addSubview(careerTableView)
        view.prepareForAutoLayout()
        return view
    }()
    
    private let pageControl: DisabledPageControl = {
        let pageControl = DisabledPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 2
        return pageControl
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .deepGreen
        view.setupCornerRadius()
        view.setupBorder(withColor: .naturalGold)
        view.addSubviews(
            titleLabel,
            fullNameLabel,
            careerLabel,
            currentLeagueLabel,
            popoverButton,
            fullNameValueLabel,
            addCareerButton,
            deletingModeButton,
            roundedContainerView,
            pageControl)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Public Properties 
    var viewModel: PlayerCareerCardViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            fullNameValueLabel.text = viewModel.fullName
            popoverButton.configuration = getButtonConfiguration(
                with: viewModel.currentLeague)
            addCareerButton.backgroundColor = .lightGray
            viewModel.getSortedCareers { [weak self] in
                guard let self else { return }
                careerTableView.reloadData()
            }
        }
    }
    
    var delegate: PlayerCareerCardDelegate?

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func getButtonConfiguration(
        with title: String
    ) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(
            title,
            attributes: AttributeContainer([.font : Constants.Fonts.text]))
        let image = Constants.Images.ButtonImages.popover?.withTintColor(
            .white.withAlphaComponent(0.7))
        let imageSize = CGSize(width: 15, height: 15)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        configuration.image = renderer.image { _ in
            image?.draw(in: CGRect(origin: .zero, size: imageSize))
        }
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0)
        return configuration
    }
    
    private func popoverButtonTapped() {
        let popoverVC = ScreenFactory.getPopoverViewController()
        popoverVC.preferredContentSize = CGSize(width: 140, height: 180)
        let presentationController = popoverVC.popoverPresentationController
        presentationController?.delegate = self
        presentationController?.sourceView = popoverButton
        presentationController?.permittedArrowDirections = .up
        presentationController?.sourceRect = CGRect(
            x: popoverButton.bounds.midX,
            y: popoverButton.bounds.maxY,
            width: 0,
            height: 0)
        delegate?.popoverButtonWasTapped?(popoverVC)
    }
    
    @objc private func addCareerButtonTapped() {
        addCareerButton.backgroundColor = .white
        delegate?.addCareerButtonWasTapped?()
    }
    
    @objc private func deletingModeButtonTapped() {
        deletingModeButton.backgroundColor = careerTableView.isEditing
        ? .lightGray
        : .white
        careerTableView.isEditing.toggle()
    }
}

// MARK: - Table View Delegate
extension PlayerCareerCard: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        50
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            viewModel?.deleteCareer(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Table View Data Source
extension PlayerCareerCard: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let identifier = String(describing: CareerTableViewCell.self)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier) as? CareerTableViewCell
        cell?.viewModel = viewModel?.getCareerCellViewModel(at: indexPath)
        return cell ?? UITableViewCell()
    }
}

// MARK: - Popover Presentation Controller Delegate
extension PlayerCareerCard: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        .none
    }
}

// MARK: - Layout
private extension PlayerCareerCard {
    
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
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16),
            
            fullNameLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 24),
            fullNameLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            currentLeagueLabel.topAnchor.constraint(
                equalTo: fullNameLabel.bottomAnchor,
                constant: 24),
            currentLeagueLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            careerLabel.topAnchor.constraint(
                equalTo: currentLeagueLabel.bottomAnchor,
                constant: 24),
            careerLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            fullNameValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            fullNameValueLabel.centerYAnchor.constraint(
                equalTo: fullNameLabel.centerYAnchor,
                constant: -2),
            
            popoverButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            popoverButton.centerYAnchor.constraint(
                equalTo: currentLeagueLabel.centerYAnchor,
                constant: -3),
            
            addCareerButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            addCareerButton.centerYAnchor.constraint(
                equalTo: careerLabel.centerYAnchor,
                constant: -4),
            addCareerButton.widthAnchor.constraint(equalToConstant: 50),
            
            deletingModeButton.trailingAnchor.constraint(
                equalTo: addCareerButton.leadingAnchor,
                constant: -12),
            deletingModeButton.centerYAnchor.constraint(
                equalTo: careerLabel.centerYAnchor,
                constant: -4),
            deletingModeButton.widthAnchor.constraint(equalToConstant: 50),
            
            roundedContainerView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 18),
            roundedContainerView.topAnchor.constraint(
                equalTo: careerLabel.bottomAnchor,
                constant: 8),
            roundedContainerView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -18),
            roundedContainerView.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor,
                constant: -16),
            
            careerTableView.topAnchor.constraint(
                equalTo: roundedContainerView.topAnchor,
                constant: 8),
            careerTableView.leadingAnchor.constraint(
                equalTo: roundedContainerView.leadingAnchor,
                constant: 6),
            careerTableView.bottomAnchor.constraint(
                equalTo: roundedContainerView.bottomAnchor,
                constant: -8),
            careerTableView.trailingAnchor.constraint(
                equalTo: roundedContainerView.trailingAnchor,
                constant: -6),
            
            pageControl.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -12)
        ])
    }
}
