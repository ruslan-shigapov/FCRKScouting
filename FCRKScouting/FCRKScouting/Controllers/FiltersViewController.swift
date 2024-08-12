//
//  FiltersViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 30.03.2024.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    // MARK: Private Properties
    private var delegate: FiltersViewControllerDelegate
    private var viewModel: FiltersViewModelProtocol
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Text.ScreenTitles.filters,
            color: .rubin)
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
        let button = PrimaryButton(title: "")
        button.addTarget(
            self,
            action: #selector(applyButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(
        delegate: FiltersViewControllerDelegate,
        viewModel: FiltersViewModelProtocol
    ) {
        self.delegate = delegate
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
        configureUI()
        handleWrongRatioOfAges()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupApplyButton()
        footSegmentedControl.setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.setKeyboardDismissTap()
        dashLabel.isHidden = true
        toAgeTextFieldView.isHidden = true
        view.backgroundColor = .deepGreen
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
    
    private func configureUI() {
        if viewModel.isFiltersActive {
            positionPickerView.selectRow(
                delegate.position,
                inComponent: 0,
                animated: true)
            leaguePickerView.selectRow(
                delegate.league,
                inComponent: 0,
                animated: true)
            footSegmentedControl.selectedSegmentIndex = delegate.foot
            ageTextFieldView.set(text: delegate.age)
            if let toAgeValue = delegate.toAge, !toAgeValue.isEmpty {
                toAgeSwitcher.isOn = true
                toAgeTextFieldView.isHidden = false
                toAgeTextFieldView.set(text: toAgeValue)
            }
        }
    }
    
    private func handleWrongRatioOfAges() {
        viewModel.wasRatioOfAgesWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.wrongRatioOfAges.title,
                andMessage: Constants.Text.Alerts.wrongRatioOfAges.message)
            present(alertController, animated: true)
        }
    }
    
    private func setupApplyButton() {
        let title = viewModel.isFiltersActive
        ? Constants.Text.ButtonTitles.reset
        : Constants.Text.ButtonTitles.apply
        applyButton.setTitle(title, for: .normal)
        let color: UIColor = viewModel.isFiltersActive
        ? .rubin
        : .systemGreen.withAlphaComponent(0.7)
        applyButton.backgroundColor = color
        
    }
    
    @objc private func toAgeSwitcherChanged() {
        dashLabel.isHidden.toggle()
        toAgeTextFieldView.isHidden.toggle()
    }
    
    @objc private func applyButtonTapped() {
        viewModel.checkRatioOf(
            age: ageTextFieldView.getInputText(),
            andAge: toAgeTextFieldView.getInputText()
        ) {
            viewModel.isFiltersActive.toggle()
            setupApplyButton()
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.4
            ) { [weak self] in
                guard let self else { return }
                delegate.position = positionPickerView.selectedRow(
                    inComponent: 0)
                delegate.league = leaguePickerView.selectedRow(inComponent: 0)
                delegate.foot = footSegmentedControl.selectedSegmentIndex
                delegate.age = ageTextFieldView.getInputText()
                delegate.toAge = toAgeTextFieldView.getInputText()
                delegate.extraFiltersWareChanged?()
                dismiss(animated: true)
            }
        }
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
            positionLabel.leadingAnchor.constraint(
                equalTo: positionPickerView.leadingAnchor),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 6),
            positionPickerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            
            leagueLabel.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 12),
            leagueLabel.leadingAnchor.constraint(
                equalTo: leaguePickerView.leadingAnchor),
            
            leaguePickerView.topAnchor.constraint(
                equalTo: leagueLabel.bottomAnchor,
                constant: 6),
            leaguePickerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            leaguePickerView.heightAnchor.constraint(equalToConstant: 96),
            
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
