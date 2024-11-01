//
//  AddTournamentViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.09.2024.
//

import UIKit

final class AddTournamentViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: AddTournamentViewModelProtocol
    private let delegate: AddTournamentViewControllerDelegate
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Texts.ScreenTitles.addTournament,
            color: .rubin)
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField = PrimaryTextFieldView(
        placeholder: Constants.Texts.Placeholders.name,
        type: .name)
    private let placeTextField = PrimaryTextFieldView(
        placeholder: Constants.Texts.Placeholders.place,
        type: .name)
    
    private let startLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.start)
    private let endLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.end)
    
    private let startDatePickerView = DatePickerView(type: .tournament)
    private let endDatePickerView = DatePickerView(type: .tournament)
    
    private let ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.age)
    private let periodLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.period)
    
    private lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toYearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
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
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(title: Constants.Texts.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
   
    // MARK: Initialize
    init(
        viewModel: AddTournamentViewModelProtocol,
        delegate: AddTournamentViewControllerDelegate
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
        handleErrors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        yearPickerView.setupShadow()
        toYearPickerView.setupShadow()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        view.setKeyboardDismissTap()
        view.backgroundColor = .deepGreen
        view.addSubviews(
            titleLabel,
            nameTextField,
            placeTextField,
            startLabel,
            startDatePickerView,
            endLabel,
            endDatePickerView,
            ageLabel,
            yearPickerView,
            periodLabel,
            toYearPickerView,
            toYearSwitcher,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleErrors() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getAlertController(
                withTitle: Constants.Texts.Alerts.emptyTextFields.title,
                andMessage: Constants.Texts.Alerts.emptyTextFields.message)
            present(alertController, animated: true)
        }
        viewModel.wasRatioOfYearsWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getAlertController(
                withTitle: Constants.Texts.Alerts.wrongRatioOfYears.title,
                andMessage: Constants.Texts.Alerts.wrongRatioOfYears.message)
            present(alertController, animated: true)
        }
        viewModel.wasRatioOfDatesWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getAlertController(
                withTitle: Constants.Texts.Alerts.wrongRatioOfDates.title,
                andMessage: Constants.Texts.Alerts.wrongRatioOfDates.message)
            present(alertController, animated: true)
        }
    }
    
    @objc private func toYearSwitcherChanged() {
        toYearPickerView.isHidden.toggle()
    }
    
    @objc private func saveButtonTapped() {
        guard toYearSwitcher.isOn else {
            viewModel.saveTournament(
                name: nameTextField.getInputText(),
                place: placeTextField.getInputText(),
                startDate: startDatePickerView.getDate(),
                endDate: endDatePickerView.getDate(),
                age: yearPickerView.selectedRow(inComponent: 0),
                toAge: nil
            ) { [weak self] in
                guard let self else { return }
                delegate.tournamentWasAdded?()
                dismiss(animated: true)
            }
            return
        }
        viewModel.checkRatioOf(
            year: yearPickerView.selectedRow(inComponent: 0),
            andYear: toYearPickerView.selectedRow(inComponent: 0)
        ) {
            viewModel.saveTournament(
                name: nameTextField.getInputText(),
                place: placeTextField.getInputText(),
                startDate: startDatePickerView.getDate(),
                endDate: endDatePickerView.getDate(),
                age: yearPickerView.selectedRow(inComponent: 0),
                toAge: toYearPickerView.selectedRow(inComponent: 0)
            ) { [weak self] in
                guard let self else { return }
                delegate.tournamentWasAdded?()
                dismiss(animated: true)
            }
        }
    }
}

// MARK: - Picker View Delegate
extension AddTournamentViewController: UIPickerViewDelegate {

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
extension AddTournamentViewController: UIPickerViewDataSource {
    
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
extension AddTournamentViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 16),
            nameTextField.widthAnchor.constraint(
                equalTo: placeTextField.widthAnchor),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            placeTextField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor,
                constant: 16),
            placeTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            placeTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            
            startLabel.topAnchor.constraint(
                equalTo: placeTextField.bottomAnchor,
                constant: 16),
            startLabel.leadingAnchor.constraint(
                equalTo: startDatePickerView.leadingAnchor),
            
            startDatePickerView.topAnchor.constraint(
                equalTo: startLabel.bottomAnchor,
                constant: 6),
            startDatePickerView.leadingAnchor.constraint(
                equalTo: placeTextField.leadingAnchor),
            
            endLabel.topAnchor.constraint(
                equalTo: placeTextField.bottomAnchor,
                constant: 16),
            endLabel.leadingAnchor.constraint(
                equalTo: endDatePickerView.leadingAnchor),
            
            endDatePickerView.topAnchor.constraint(
                equalTo: endLabel.bottomAnchor,
                constant: 6),
            endDatePickerView.trailingAnchor.constraint(
                equalTo: placeTextField.trailingAnchor),
            
            ageLabel.topAnchor.constraint(
                equalTo: startDatePickerView.bottomAnchor,
                constant: 20),
            ageLabel.leadingAnchor.constraint(
                equalTo: startDatePickerView.leadingAnchor),
            
            yearPickerView.topAnchor.constraint(
                equalTo: ageLabel.bottomAnchor,
                constant: 6),
            yearPickerView.leadingAnchor.constraint(
                equalTo: ageLabel.leadingAnchor),
            yearPickerView.heightAnchor.constraint(equalToConstant: 70),
            yearPickerView.widthAnchor.constraint(equalToConstant: 145),
            
            toYearPickerView.trailingAnchor.constraint(
                equalTo: placeTextField.trailingAnchor),
            toYearPickerView.widthAnchor.constraint(
                equalTo: yearPickerView.widthAnchor),
            toYearPickerView.heightAnchor.constraint(
                equalTo: yearPickerView.heightAnchor),
            toYearPickerView.centerYAnchor.constraint(
                equalTo: yearPickerView.centerYAnchor),
            
            periodLabel.leadingAnchor.constraint(
                equalTo: toYearPickerView.leadingAnchor),
            periodLabel.centerYAnchor.constraint(
                equalTo: ageLabel.centerYAnchor),
            
            toYearSwitcher.trailingAnchor.constraint(
                equalTo: endDatePickerView.trailingAnchor),
            toYearSwitcher.centerYAnchor.constraint(
                equalTo: periodLabel.centerYAnchor,
                constant: -4),
            
            saveButton.topAnchor.constraint(
                equalTo: toYearPickerView.bottomAnchor,
                constant: 20),
            saveButton.widthAnchor.constraint(
                equalTo: placeTextField.widthAnchor),
            saveButton.centerXAnchor.constraint(
                equalTo: placeTextField.centerXAnchor)
        ])
    }
}
