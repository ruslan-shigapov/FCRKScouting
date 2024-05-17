//
//  PlayerAddingViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class PlayerAddingViewController: UIViewController {
    
    // MARK: Private Properties 
    private var viewModel: PlayerAddingViewModelProtocol
    private var delegate: PlayerAddingViewControllerDelegate
    
    // MARK: Views
    private let titleLabel = CustomWhiteLabel(font: Constants.Fonts.header)
    
    private lazy var closeButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.close
        )
        button.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private let photoImageView = PhotoImageView()
    
    private lazy var uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .label
        button.setTitle(Constants.Text.ButtonTitles.uploadPhoto, for: .normal)
        button.setCustomCornerRadius()
        button.setCustomShadow()
        button.addTarget(
            self,
            action: #selector(uploadPhotoButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private let fullNameTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name
    )
    private let citizenshipTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.citizenship,
        type: .name,
        tag: 2
    )
    private let clubTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.club,
        type: .name,
        tag: 3
    )
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameTextFieldView,
                citizenshipTextFieldView,
                clubTextFieldView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let birthDateLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    
    private let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    private let positionLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    
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
    
    private let footLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    
    private let footSegmentedControl = GraySegmentedControl(
        items: Constants.Text.SegmentedControlItems.footSegments
    )
    
    private let generalInfoTextViewWithTitle = TextViewWithTitle(
        title: Constants.Text.TextViewTitles.generalInfo
    )
    private let techniqueTextViewWithTitle = TextViewWithTitle(
        title: Constants.Text.TextViewTitles.technique
    )
    private let tacticsTextViewWithTitle = TextViewWithTitle(
        title: Constants.Text.TextViewTitles.tactics
    )
    private let qualitiesTextViewWithTitle = TextViewWithTitle(
        title: Constants.Text.TextViewTitles.qualities
    )
    private let mentalTextViewWithTitle = TextViewWithTitle(
        title: Constants.Text.TextViewTitles.mental
    )
    
    private lazy var textViewStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                generalInfoTextViewWithTitle,
                techniqueTextViewWithTitle,
                tacticsTextViewWithTitle,
                qualitiesTextViewWithTitle,
                mentalTextViewWithTitle
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.subviews.forEach {
            if let textFieldView = $0 as? RoundedTextFieldView {
                textFieldView.setDelegate(self)
            }
        }
        return stackView
    }()
    
    private lazy var saveAddingButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.saveAdding
        )
        button.addTarget(
            self,
            action: #selector(saveAddingButtonTapped),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews(
            photoImageView,
            uploadPhotoButton,
            textFieldStackView,
            birthDateLabel,
            birthDatePicker,
            positionLabel,
            positionPickerView,
            footLabel,
            footSegmentedControl,
            textViewStackView,
            saveAddingButton
        )
        scrollView.prepareForAutoLayout()
        return scrollView
    }()
    
    // MARK: Initialize
    init(
        viewModel: PlayerAddingViewModelProtocol,
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
        view.setCustomAccentAndGreenGradient()
        view.addSubviews(titleLabel, closeButton, verticalScrollView)
        view.prepareForAutoLayout()
        setConstraints()
        configureLabels()
        setupAlerts()
        addTapGesture()
    }
    
    private func configureLabels() {
        titleLabel.text = Constants.Text.ScreenTitles.addPlayer
        birthDateLabel.text = Constants.Text.birthDate
        positionLabel.text = Constants.Text.position
        footLabel.text = Constants.Text.foot
    }
    
    private func setupAlerts() {
        viewModel.wasAnyTextFieldEmpty = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.emptyTextField.title,
                andMessage: Constants.Text.Alerts.emptyTextField.message
            )
            self?.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message
            )
            self?.present(alertController, animated: true)
        }
        viewModel.wasPositionNotSelected = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.notSelectedPosition.title,
                andMessage: Constants.Text.Alerts.notSelectedPosition.message
            )
            self?.present(alertController, animated: true)
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        verticalScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func closeButtonTapped() {
        let cancelAlert = AlertFactory.getCancelAlert(
            withTitle: Constants.Text.ActionSheets.cancelAdding
        ) { [weak self] in
            self?.dismiss(animated: true)
        }
        present(cancelAlert, animated: true)
    }
    
    @objc private func uploadPhotoButtonTapped() {
        
    }
    
    @objc private func saveAddingButtonTapped() {
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
                generalInfo: generalInfoTextViewWithTitle.getInputText(),
                technique: techniqueTextViewWithTitle.getInputText(),
                tactics: tacticsTextViewWithTitle.getInputText(),
                qualities: qualitiesTextViewWithTitle.getInputText(),
                mental: mentalTextViewWithTitle.getInputText()
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
extension PlayerAddingViewController: UITextFieldDelegate {
    
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
extension PlayerAddingViewController: UIPickerViewDataSource {
    
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
extension PlayerAddingViewController: UIPickerViewDelegate {
    
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
extension PlayerAddingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor,
                constant: 2
            ),
            
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 4
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            
            verticalScrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 12
            ),
            verticalScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            verticalScrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            verticalScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            photoImageView.topAnchor.constraint(
                equalTo: verticalScrollView.topAnchor
            ),
            photoImageView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            uploadPhotoButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor
            ),
            uploadPhotoButton.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor
            ),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 12
            ),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            birthDateLabel.centerYAnchor.constraint(
                equalTo: birthDatePicker.centerYAnchor
            ),
            
            birthDatePicker.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 12
            ),
            birthDatePicker.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor
            ),
            
            positionLabel.topAnchor.constraint(
                equalTo: birthDatePicker.bottomAnchor,
                constant: 12
            ),
            positionLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 8
            ),
            positionPickerView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor
            ),
            
            footLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            footLabel.centerYAnchor.constraint(
                equalTo: footSegmentedControl.centerYAnchor
            ),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 12
            ),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor
            ),
            
            textViewStackView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 12
            ),
            textViewStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24
            ),
            textViewStackView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor
            ),
            
            saveAddingButton.topAnchor.constraint(
                equalTo: textViewStackView.bottomAnchor,
                constant: 24
            ),
            saveAddingButton.bottomAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor,
                constant: -24
            ),
            saveAddingButton.centerXAnchor.constraint(
                equalTo: verticalScrollView.centerXAnchor
            )
        ])
    }
}
