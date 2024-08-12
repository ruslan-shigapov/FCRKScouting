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
            text: Constants.Text.ScreenTitles.career,
            numberOfLines: 2,
            color: .rubin)
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.fullName)
    private let careerLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.career)
    
    private let fullNameValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addCareerButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.backgroundColor = .lightGray
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
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
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
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
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
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupCornerRadius()
        view.setupBorder()
        view.addSubviews(
            titleLabel,
            fullNameLabel,
            careerLabel,
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
            fullNameValueLabel.text = viewModel?.fullName
            addCareerButton.backgroundColor = .lightGray
            viewModel?.getSortedCareers { [weak self] in
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        prepareForAutoLayout()
        setConstraints()
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
            
            careerLabel.topAnchor.constraint(
                equalTo: fullNameLabel.bottomAnchor,
                constant: 24),
            careerLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            fullNameValueLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.trailingAnchor,
                constant: 8),
            fullNameValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -8),
            fullNameValueLabel.centerYAnchor.constraint(
                equalTo: fullNameLabel.centerYAnchor,
                constant: -2),
            
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
