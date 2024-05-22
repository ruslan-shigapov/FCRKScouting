//
//  EditorViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class EditorViewController: UIViewController {
    
    // MARK: Private Properties 
    private var viewModel: EditorViewModelProtocol
    private var delegate: PlayerAddingViewControllerDelegate
    
    // MARK: Views
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        text: Constants.Text.ScreenTitles.addPlayer)
    
    private lazy var closeButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.close)
        button.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let photoImageView = PhotoImageView()
    
    private lazy var uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .label
        button.titleLabel?.font = Constants.Fonts.description
        button.setTitle(Constants.Text.ButtonTitles.uploadPhoto, for: .normal)
        button.setCustomCornerRadius()
        button.setCustomShadow()
        button.addTarget(
            self,
            action: #selector(uploadPhotoButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let fullNameTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    private let citizenshipTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.citizenship,
        type: .name,
        tag: 2)
    private let clubTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.club,
        type: .name,
        tag: 3)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameTextFieldView,
                citizenshipTextFieldView,
                clubTextFieldView
            ])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.subviews.forEach {
            if let textFieldView = $0 as? RoundedTextFieldView {
                textFieldView.set(delegate: self)
            }
        }
        return stackView
    }()
    
    private lazy var addPatronymicTextFieldButton: UIButton = {
        let button = AddTextFieldButton()
        button.addTarget(
            self,
            action: #selector(addPatronymicTextFieldButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var addNationalTeamTextFieldButton: UIButton = {
        let button = AddTextFieldButton()
        button.addTarget(
            self,
            action: #selector(addNationalTeamTextFieldButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let birthDateLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: Constants.Text.birthDate)
    
    private let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    private lazy var datePickerBackgroundView: UIView = {
        let view = UIView()
        view.addSubview(birthDatePicker)
        view.backgroundColor = .white
        view.setCustomCornerRadius()
        view.setCustomShadow()
        return view
    }()
    
    private let positionLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.position)
    
    private lazy var positionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.setCustomCornerRadius()
        pickerView.clipsToBounds = false
        pickerView.setCustomShadow()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private let footLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.foot)
    
    private let footSegmentedControl = GraySegmentedControl(
        items: Constants.Text.SegmentedControlItems.footSegments)
    
    private let generalInfoTextViewWithTitle = TextViewWithTitle(
        view: CustomWhiteLabel(
            font: Constants.Fonts.normal,
            text: Constants.Text.TextViewTitles.generalInfo))
    // TODO: temporary decision >>
    private lazy var peculiaritiesTextViewWithTitle = TextViewWithTitle(
        view: GraySegmentedControl(
            items: [
                Constants.Text.TextViewTitles.technique,
                Constants.Text.TextViewTitles.tactics,
                Constants.Text.TextViewTitles.qualities,
                Constants.Text.TextViewTitles.mental
            ]))
    
    private lazy var textViewStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                generalInfoTextViewWithTitle,
                peculiaritiesTextViewWithTitle
            ])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    private lazy var verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews(
            photoImageView,
            uploadPhotoButton,
            textFieldStackView,
            addPatronymicTextFieldButton,
            addNationalTeamTextFieldButton,
            datePickerBackgroundView,
            birthDateLabel,
            positionLabel,
            positionPickerView,
            footLabel,
            footSegmentedControl,
            textViewStackView)
        scrollView.prepareForAutoLayout()
        return scrollView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(
        viewModel: EditorViewModelProtocol,
        delegate: PlayerAddingViewControllerDelegate
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
        view.backgroundColor = Constants.Colors.deepGreen
        view.addSubviews(
            titleLabel,
            closeButton,
            verticalScrollView,
            dividerView,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
        addTapGesture()
    }
    
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.emptyTextFields.title,
                andMessage: Constants.Text.Alerts.emptyTextFields.message)
            self?.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            self?.present(alertController, animated: true)
        }
        viewModel.wasPositionNotSelected = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.notSelectedPosition.title,
                andMessage: Constants.Text.Alerts.notSelectedPosition.message)
            self?.present(alertController, animated: true)
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        verticalScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func closeButtonTapped() {
        let cancelAlert = AlertFactory.getCancelActionSheet(
            withTitle: Constants.Text.ActionSheets.cancelAdding,
            andButtonTitle: Constants.Text.ButtonTitles.continueAdding
        ) { [weak self] in
            self?.dismiss(animated: true)
        }
        present(cancelAlert, animated: true)
    }
    
    @objc private func uploadPhotoButtonTapped() {
        
    }
    
    @objc private func addPatronymicTextFieldButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @objc private func addNationalTeamTextFieldButtonTapped(
        _ sender: UIButton
    ) {
        sender.isSelected.toggle()
    }
    
    @objc private func saveButtonTapped() {
        viewModel.validateInput(
            text: [
                fullNameTextFieldView.getInputText(),
                citizenshipTextFieldView.getInputText(),
                clubTextFieldView.getInputText()
            ]
        ) {
            viewModel.savePlayer(
                byFullName: $0[0],
                citizenship: $0[1],
                club: $0[2],
                birthDate: birthDatePicker.date,
                position: positionPickerView.selectedRow(inComponent: 0),
                foot: footSegmentedControl.selectedSegmentIndex,
                generalInfo: generalInfoTextViewWithTitle.getInputText()
//                technique: techniqueTextViewWithTitle.getInputText(),
//                tactics: tacticsTextViewWithTitle.getInputText(),
//                qualities: qualitiesTextViewWithTitle.getInputText(),
//                mental: mentalTextViewWithTitle.getInputText()
            ) { [weak self] in
                self?.dismiss(animated: true) { [weak self] in
                    self?.delegate.playerWasAdded?()
                }
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Text Field Delegate
extension EditorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTF = textField.superview?.superview?.superview?.viewWithTag(
            textField.tag + 1) as? UITextField {
            nextTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Picker View Data Source
extension EditorViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.getNumberOfComponentsInPicker()
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        viewModel.getNumberOfRowsInPicker()
    }
}

// MARK: - Picker View Delegate
extension EditorViewController: UIPickerViewDelegate {
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = viewModel.getTitleFor(pickerRow: row)
        rowLabel.font = Constants.Fonts.text
        rowLabel.textAlignment = .center
        return rowLabel
    }
}

// MARK: - Layout
extension EditorViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor,
                constant: 2),
            
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 4),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            verticalScrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 12),
            verticalScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            photoImageView.topAnchor.constraint(
                equalTo: verticalScrollView.topAnchor),
            photoImageView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            photoImageView.heightAnchor.constraint(equalToConstant: 110),
            photoImageView.widthAnchor.constraint(equalToConstant: 110),
            
            uploadPhotoButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            uploadPhotoButton.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            uploadPhotoButton.heightAnchor.constraint(equalToConstant: 32),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 12),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            
            addPatronymicTextFieldButton.centerYAnchor.constraint(
                equalTo: fullNameTextFieldView.centerYAnchor,
                constant: -2),
            addPatronymicTextFieldButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            addNationalTeamTextFieldButton.centerYAnchor.constraint(
                equalTo: clubTextFieldView.centerYAnchor,
                constant: -2),
            addNationalTeamTextFieldButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            datePickerBackgroundView.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 24),
            datePickerBackgroundView.trailingAnchor.constraint(
                equalTo: textViewStackView.trailingAnchor),
            datePickerBackgroundView.heightAnchor.constraint(equalToConstant: 35),
            datePickerBackgroundView.widthAnchor.constraint(equalTo: birthDatePicker.widthAnchor),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            birthDateLabel.centerYAnchor.constraint(
                equalTo: datePickerBackgroundView.centerYAnchor,
                constant: 1),
            birthDateLabel.widthAnchor.constraint(equalToConstant: 120),
            
            birthDatePicker.centerXAnchor.constraint(
                equalTo: datePickerBackgroundView.centerXAnchor),
            birthDatePicker.centerYAnchor.constraint(
                equalTo: datePickerBackgroundView.centerYAnchor),
            
            positionLabel.topAnchor.constraint(
                equalTo: birthDatePicker.bottomAnchor,
                constant: 24),
            positionLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 8),
            positionPickerView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            
            footLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 24),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            footSegmentedControl.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -1),
            
            textViewStackView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 24),
            textViewStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            textViewStackView.bottomAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor,
                constant: -24),
            textViewStackView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            
            dividerView.topAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            saveButton.topAnchor.constraint(
                equalTo: dividerView.bottomAnchor,
                constant: 12),
            saveButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            saveButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
