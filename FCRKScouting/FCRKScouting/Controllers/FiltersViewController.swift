//
//  FiltersViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 30.03.2024.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: FiltersViewModelProtocol
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Text.ScreenTitles.filters,
            color: .accent)
        label.textAlignment = .center
        return label
    }()
    
    private let positionLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.position)
    private let leagueLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.league)
    private let footLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.foot,
        numberOfLines: 2)
    private let ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.age)
    private let dashLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.dash)
    
    private let positionPickerView = CustomPickerView(type: .position)
    private let leaguePickerView = CustomPickerView(type: .league)
    
    private let footSegmentedControl = GraySegmentedControl(
        items: ["любая"] + Constants.Text.SegmentedControlItems.footSegments)
    
    private let ageTextFieldView = NumeralTextFieldView(type: .age)
    private let toAgeTextFieldView = NumeralTextFieldView(type: .age)
    
    private lazy var toAgeSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.backgroundColor = .white
        switcher.layer.cornerRadius = 16
        switcher.addTarget(
            self,
            action: #selector(toAgeSwitcherChanged),
            for: .valueChanged)
        return switcher
    }()
    
    private lazy var applyButton: PrimaryButton = {
        let title = viewModel.isFiltersActive
        ? "Сбросить"
        : "Применить"
        let color: UIColor = viewModel.isFiltersActive
        ? .accent
        : .systemGreen.withAlphaComponent(0.7)
        let button = PrimaryButton(
            title: title,
            color: color)
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    
    // MARK: Initialize
    init(viewModel: FiltersViewModelProtocol) {
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        footSegmentedControl.setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.setKeyboardDismissTap()
        dashLabel.isHidden = true
        toAgeTextFieldView.isHidden = true
        view.backgroundColor = .lightGray
        view.addSubviews(
            titleLabel,
            positionLabel,
            positionPickerView,
            leagueLabel,
            leaguePickerView,
            footLabel,
            footSegmentedControl,
            ageLabel,
            ageTextFieldView,
            dashLabel,
            toAgeTextFieldView,
            toAgeSwitcher,
            applyButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    @objc private func toAgeSwitcherChanged() {
        dashLabel.isHidden.toggle()
        toAgeTextFieldView.isHidden.toggle()
    }
}

// MARK: - Layout
private extension FiltersViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            positionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 12),
            positionLabel.centerXAnchor.constraint(
                equalTo: positionPickerView.centerXAnchor),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 6),
            positionPickerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            positionPickerView.heightAnchor.constraint(equalToConstant: 70),
            
            leagueLabel.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 12),
            leagueLabel.centerXAnchor.constraint(
                equalTo: leaguePickerView.centerXAnchor),
            
            leaguePickerView.topAnchor.constraint(
                equalTo: leagueLabel.bottomAnchor,
                constant: 6),
            leaguePickerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            leaguePickerView.heightAnchor.constraint(equalToConstant: 70),
            
            footLabel.leadingAnchor.constraint(
                equalTo: leaguePickerView.leadingAnchor),
            footLabel.widthAnchor.constraint(equalToConstant: 100),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: leaguePickerView.bottomAnchor,
                constant: 16),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: leaguePickerView.trailingAnchor),
            footSegmentedControl.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -2),
            
            ageLabel.leadingAnchor.constraint(
                equalTo: leaguePickerView.leadingAnchor),
            ageLabel.centerYAnchor.constraint(
                equalTo: toAgeSwitcher.centerYAnchor),
            
            toAgeSwitcher.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 16),
            toAgeSwitcher.trailingAnchor.constraint(
                equalTo: leaguePickerView.trailingAnchor),
            
            toAgeTextFieldView.centerYAnchor.constraint(
                equalTo: toAgeSwitcher.centerYAnchor),
            toAgeTextFieldView.trailingAnchor.constraint(
                equalTo: toAgeSwitcher.leadingAnchor,
                constant: -16),
            
            ageTextFieldView.centerYAnchor.constraint(
                equalTo: toAgeSwitcher.centerYAnchor),
            ageTextFieldView.leadingAnchor.constraint(
                equalTo: ageLabel.trailingAnchor,
                constant: 12),
            
            dashLabel.trailingAnchor.constraint(
                equalTo: toAgeTextFieldView.leadingAnchor,
                constant: -12),
            dashLabel.centerYAnchor.constraint(
                equalTo: ageTextFieldView.centerYAnchor),
            
            applyButton.topAnchor.constraint(
                equalTo: ageTextFieldView.bottomAnchor,
                constant: 16),
            applyButton.widthAnchor.constraint(
                equalTo: leaguePickerView.widthAnchor),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
