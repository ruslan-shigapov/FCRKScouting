//
//  AddCareerViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.07.2024.
//

import UIKit

final class AddCareerViewController: UIViewController {
    
    // MARK: Private Properties
    private var delegate: AddCareerViewControllerDelegate
    private var viewModel: AddCareerViewModelProtocol
    
    // MARK: Views
    private let yearLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.year)
    private let dashLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.dash)
    private let periodLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.period)
    
    private lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toYearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toYearSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.backgroundColor = .white
        switcher.layer.cornerRadius = 16
        switcher.addTarget(
            self,
            action: #selector(toYearSwitcherChanged),
            for: .valueChanged)
        return switcher
    }()
    
    private lazy var leaguePickerView = CustomPickerView(type: .league)
    
    private let coachTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.coach,
        type: .name)
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(title: Constants.Text.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(
        delegate: AddCareerViewControllerDelegate,
        viewModel: AddCareerViewModelProtocol
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
        handleErrors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        yearPickerView.setupShadow()
        toYearPickerView.setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setKeyboardDismissTap()
        dashLabel.isHidden = true
        view.backgroundColor = .accent
        view.addSubviews(
            yearLabel,
            yearPickerView,
            dashLabel,
            periodLabel,
            toYearSwitcher,
            toYearPickerView,
            leaguePickerView,
            coachTextFieldView,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleErrors() {
        viewModel.wasRatioOfYearsWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.wrongRatioOfYears.title,
                andMessage: Constants.Text.Alerts.wrongRatioOfYears.message)
            present(alertController, animated: true)
        }
        viewModel.wereYearsRepeated = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.repeatedYears.title,
                andMessage: Constants.Text.Alerts.repeatedYears.message)
            present(alertController, animated: true)
        }
    }
    
    private func setKeyboardDismissTap() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func toYearSwitcherChanged() {
        toYearPickerView.isHidden.toggle()
        dashLabel.isHidden.toggle()
    }
    
    @objc private func saveButtonTapped() {
        let yearPickerSelectedRow = yearPickerView.selectedRow(inComponent: 0)
        let leaguePickerSelectedRow = leaguePickerView.selectedRow(
            inComponent: 0)
        guard toYearSwitcher.isOn else {
            viewModel.saveCareer(
                forYear: yearPickerSelectedRow,
                toYear: nil,
                league: leaguePickerSelectedRow,
                coach: coachTextFieldView.getInputText()
            ) { [weak self] in
                guard let self else { return }
                dismiss(animated: true)
            }
            return
        }
        let toYearPickerSelectedRow = toYearPickerView.selectedRow(
            inComponent: 0)
        viewModel.checkRatioOf(
            year: yearPickerSelectedRow,
            andYear: toYearPickerSelectedRow
        ) {
            viewModel.saveCareer(
                forYear: yearPickerSelectedRow,
                toYear: toYearPickerSelectedRow,
                league: leaguePickerSelectedRow,
                coach: coachTextFieldView.getInputText()
            ) { [weak self] in
                guard let self else { return }
                dismiss(animated: true)
            }
        }
    }
    
    deinit {
        delegate.addCareerScreenWasClosed?()
    }
}

// MARK: - Picker View Delegate
extension AddCareerViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = String(viewModel.years[row])
        rowLabel.font = Constants.Fonts.text
        rowLabel.textColor = .black
        rowLabel.textAlignment = .center
        return rowLabel
    }
}

// MARK: - Picker View Data Source
extension AddCareerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        viewModel.years.count
    }
}

// MARK: - Layout
private extension AddCareerViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            yearLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            yearPickerView.topAnchor.constraint(
                equalTo: yearLabel.bottomAnchor,
                constant: 8),
            yearPickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            yearPickerView.heightAnchor.constraint(equalToConstant: 70),
            yearPickerView.widthAnchor.constraint(equalToConstant: 150),
            
            dashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dashLabel.centerYAnchor.constraint(
                equalTo: yearPickerView.centerYAnchor),
            
            toYearPickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            toYearPickerView.centerYAnchor.constraint(
                equalTo: yearPickerView.centerYAnchor),
            toYearPickerView.heightAnchor.constraint(equalToConstant: 70),
            toYearPickerView.widthAnchor.constraint(equalToConstant: 150),
            
            periodLabel.centerYAnchor.constraint(
                equalTo: yearLabel.centerYAnchor),
            periodLabel.leadingAnchor.constraint(
                equalTo: toYearPickerView.leadingAnchor),
            
            toYearSwitcher.centerYAnchor.constraint(
                equalTo: yearLabel.centerYAnchor,
                constant: -4),
            toYearSwitcher.trailingAnchor.constraint(
                equalTo: toYearPickerView.trailingAnchor),
            
            leaguePickerView.centerXAnchor.constraint(
                equalTo: dashLabel.centerXAnchor),
            leaguePickerView.topAnchor.constraint(
                equalTo: yearPickerView.bottomAnchor,
                constant: 16),
            leaguePickerView.heightAnchor.constraint(equalToConstant: 70),
            leaguePickerView.widthAnchor.constraint(
                equalTo: coachTextFieldView.widthAnchor),
            
            coachTextFieldView.topAnchor.constraint(
                equalTo: leaguePickerView.bottomAnchor,
                constant: 16),
            coachTextFieldView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            coachTextFieldView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            
            saveButton.topAnchor.constraint(
                equalTo: coachTextFieldView.bottomAnchor,
                constant: 16),
            saveButton.widthAnchor.constraint(
                equalTo: coachTextFieldView.widthAnchor),
            saveButton.centerXAnchor.constraint(
                equalTo: coachTextFieldView.centerXAnchor)
        ])
    }
}
