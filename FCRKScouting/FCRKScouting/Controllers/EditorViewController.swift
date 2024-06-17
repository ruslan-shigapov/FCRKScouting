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
    private var delegate: EditorViewControllerDelegate
    
    private lazy var pickerViewDelegate = EditorPickerViewDelegate(viewModel)
    private lazy var pickerViewDataSource = EditorPickerViewDataSource(
        viewModel)
    
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
        button.addTarget(
            self,
            action: #selector(uploadPhotoButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let fullNameTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    private let patronymicTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.patronymic,
        type: .name)
    private let citizenshipTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.citizenship,
        type: .name)
    private let clubTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.club,
        type: .name)
    private let nationalTeamTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.nationalTeam,
        type: .name)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameTextFieldView,
                citizenshipTextFieldView,
                clubTextFieldView
            ])
        stackView.axis = .vertical
        stackView.spacing = 24
        for (index, view) in stackView.subviews.enumerated() {
            if let textFieldView = view as? PrimaryTextFieldView {
                textFieldView.set(tag: index)
            }
        }
        return stackView
    }()
    
    private lazy var togglePatronymicFieldDisplayButton: UIButton = {
        let button = ToggleTextFieldDisplayButton()
        button.addTarget(
            self,
            action: #selector(togglePatronymicFieldDisplayButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var toggleNationalTeamFieldDisplayButton: UIButton = {
        let button = ToggleTextFieldDisplayButton()
        button.addTarget(
            self,
            action: #selector(toggleNationalTeamFieldDisplayButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let birthDateLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: Constants.Text.birthDate)
    
    private let birthDatePickerView = DatePickerView(type: .birth)
    
    private let positionLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.position)
    
    private lazy var positionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.setCustomCornerRadius()
        pickerView.delegate = pickerViewDelegate
        pickerView.dataSource = pickerViewDataSource
        return pickerView
    }()
    
    private let footLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.foot)
    
    private let footSegmentedControl = CustomSegmentedControl(
        items: Constants.Text.SegmentedControlItems.footSegments)
    
    private let generalInfoTextViewWithTitle = TextViewWithTitle(
        Constants.Text.TextViewTitles.generalInfo)
    private let techniqueTextViewWithTitle = TextViewWithTitle(
        Constants.Text.TextViewTitles.technique)
    private let tacticsTextViewWithTitle = TextViewWithTitle(
        Constants.Text.TextViewTitles.tactics)
    private let qualitiesTextViewWithTitle = TextViewWithTitle(
        Constants.Text.TextViewTitles.qualities)
    private let mentalTextViewWithTitle = TextViewWithTitle(
        Constants.Text.TextViewTitles.mental)
    
    private let pageSliderView = PageSliderView()
    
    private let pageSliderViewDescription = DescriptionLabel(
        text: Constants.Text.Descriptions.textView)
    
    private lazy var showAthleticDetailsButton: UIButton = {
        let button = DetailsButton(
            title: Constants.Text.ButtonTitles.athleticDetails)
        button.addTarget(
            self,
            action: #selector(showAthleticDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var showCareerDetailsButton: UIButton = {
        let button = DetailsButton(
            title: Constants.Text.ButtonTitles.career)
        button.addTarget(
            self,
            action: #selector(showCareerDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var showTransferDetailsButton: UIButton = {
        let button = DetailsButton(title: Constants.Text.transferDetails)
        button.addTarget(
            self,
            action: #selector(showTransferDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews(
            photoImageView,
            uploadPhotoButton,
            textFieldStackView,
            togglePatronymicFieldDisplayButton,
            toggleNationalTeamFieldDisplayButton,
            birthDatePickerView,
            birthDateLabel,
            positionLabel,
            positionPickerView,
            footLabel,
            footSegmentedControl,
            pageSliderView,
            pageSliderViewDescription,
            showCareerDetailsButton,
            showAthleticDetailsButton,
            showTransferDetailsButton)
        scrollView.prepareForAutoLayout()
        return scrollView
    }()
    
    private let dividerView = UIView()
    
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
        delegate: EditorViewControllerDelegate
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uploadPhotoButton.setCustomShadow()
        positionPickerView.setCustomShadow()
        footSegmentedControl.setCustomShadow()
        pageSliderView.configureWith(
            pages: [
                generalInfoTextViewWithTitle,
                techniqueTextViewWithTitle,
                tacticsTextViewWithTitle,
                qualitiesTextViewWithTitle,
                mentalTextViewWithTitle
            ])
    }
    
    // MARK: Private Methods
    private func setupUI() {
        dividerView.backgroundColor = .lightGray
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            closeButton,
            verticalScrollView,
            dividerView,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
    
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.emptyTextFields.title,
                andMessage: Constants.Text.Alerts.emptyTextFields.message)
            self.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            self.present(alertController, animated: true)
        }
        viewModel.wasPositionNotSelected = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.notSelectedPosition.title,
                andMessage: Constants.Text.Alerts.notSelectedPosition.message)
            self.present(alertController, animated: true)
        }
    }
    
    @objc private func closeButtonTapped() {
        let cancelAlert = AlertFactory.getCancelActionSheet(
            withTitle: Constants.Text.ActionSheets.cancelAdding,
            andButtonTitle: Constants.Text.ButtonTitles.continueAdding
        ) { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        present(cancelAlert, animated: true)
    }
    
    @objc private func uploadPhotoButtonTapped() {
        // TODO: добавить логику загрузки фото
    }
    
    @objc private func togglePatronymicFieldDisplayButtonTapped(
        _ sender: UIButton
    ) {
        sender.isSelected.toggle()
        if sender.isSelected {
            textFieldStackView.insertArrangedSubview(
                patronymicTextFieldView,
                at: 1)
        } else {
            textFieldStackView.removeArrangedSubview(patronymicTextFieldView)
            patronymicTextFieldView.removeFromSuperview()
        }
    }
    
    @objc private func toggleNationalTeamFieldDisplayButtonTapped(
        _ sender: UIButton
    ) {
        sender.isSelected.toggle()
        if sender.isSelected {
            textFieldStackView.addArrangedSubview(nationalTeamTextFieldView)
        } else {
            textFieldStackView.removeArrangedSubview(nationalTeamTextFieldView)
            nationalTeamTextFieldView.removeFromSuperview()
        }
    }
    
    @objc private func showAthleticDetailsButtonTapped() {
        let athleticDetailsVC = ScreenFactory.getAthleticDetailsVCWith(
            delegate: viewModel as AthleticDetailsViewControllerDelegate)
        present(athleticDetailsVC, animated: true)
    }
    
    @objc private func showCareerDetailsButtonTapped() {
        
    }
    
    @objc private func showTransferDetailsButtonTapped() {
        let transferDetails = ScreenFactory.getTransferDetailsVCWith(
            delegate: viewModel as TransferDetailsViewControllerDelegate)
        present(transferDetails, animated: true)
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
                patronymic: patronymicTextFieldView.getInputText(),
                citizenship: $0[1],
                club: $0[2],
                nationalTeam: nationalTeamTextFieldView.getInputText(),
                birthDate: birthDatePickerView.getDate(),
                position: positionPickerView.selectedRow(inComponent: 0),
                foot: footSegmentedControl.selectedSegmentIndex,
                generalInfo: generalInfoTextViewWithTitle.getInputText(),
                technique: techniqueTextViewWithTitle.getInputText(),
                tactics: tacticsTextViewWithTitle.getInputText(),
                qualities: qualitiesTextViewWithTitle.getInputText(),
                mental: mentalTextViewWithTitle.getInputText()
            ) { [weak self] in
                guard let self else { return }
                self.dismiss(animated: true) {
                    self.delegate.playerWasAdded?()
                }
            }
        }
    }
}

// MARK: - Layout
extension EditorViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor,
                constant: 2),
            
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 4),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
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
            photoImageView.trailingAnchor.constraint(
                equalTo: uploadPhotoButton.leadingAnchor,
                constant: -24),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
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
                constant: 16),
            textFieldStackView.trailingAnchor.constraint(
                equalTo: togglePatronymicFieldDisplayButton.leadingAnchor,
                constant: -16),
            
            togglePatronymicFieldDisplayButton.centerYAnchor.constraint(
                equalTo: fullNameTextFieldView.centerYAnchor,
                constant: -2),
            togglePatronymicFieldDisplayButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            toggleNationalTeamFieldDisplayButton.centerYAnchor.constraint(
                equalTo: clubTextFieldView.centerYAnchor,
                constant: -2),
            toggleNationalTeamFieldDisplayButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            birthDatePickerView.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 24),
            birthDatePickerView.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            birthDateLabel.centerYAnchor.constraint(
                equalTo: birthDatePickerView.centerYAnchor,
                constant: 2),
            birthDateLabel.widthAnchor.constraint(equalToConstant: 120),
            
            positionLabel.topAnchor.constraint(
                equalTo: birthDatePickerView.bottomAnchor,
                constant: 24),
            positionLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 8),
            positionPickerView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            
            footLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 24),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            footSegmentedControl.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -2),
            
            pageSliderView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 32),
            pageSliderView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            pageSliderView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor,
                constant: 20),
            pageSliderView.heightAnchor.constraint(equalToConstant: 140),
            
            pageSliderViewDescription.topAnchor.constraint(
                equalTo: pageSliderView.bottomAnchor,
                constant: -12),
            pageSliderViewDescription.leadingAnchor.constraint(
                equalTo: pageSliderView.leadingAnchor,
                constant: 5),
            pageSliderViewDescription.trailingAnchor.constraint(
                equalTo: pageSliderView.trailingAnchor,
                constant: -5),
            
            showAthleticDetailsButton.topAnchor.constraint(
                equalTo: pageSliderViewDescription.bottomAnchor,
                constant: 24),
            showAthleticDetailsButton.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            showAthleticDetailsButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            showCareerDetailsButton.topAnchor.constraint(
                equalTo: showAthleticDetailsButton.bottomAnchor,
                constant: 16),
            showCareerDetailsButton.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            showCareerDetailsButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            showTransferDetailsButton.topAnchor.constraint(
                equalTo: showCareerDetailsButton.bottomAnchor,
                constant: 16),
            showTransferDetailsButton.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 16),
            showTransferDetailsButton.bottomAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor,
                constant: -24),
            showTransferDetailsButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            dividerView.topAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            saveButton.topAnchor.constraint(
                equalTo: dividerView.bottomAnchor,
                constant: 12),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            saveButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -12),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            saveButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
