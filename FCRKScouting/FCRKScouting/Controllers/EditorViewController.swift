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
    
    private lazy var imagePickerDelegate = EditorImagePickerDelegate(
        viewModel: viewModel)
    
    private lazy var pickerViewDelegate = EditorPickerViewDelegate(
        viewModel: viewModel)
    private lazy var pickerViewDataSource = EditorPickerViewDataSource(
        viewModel: viewModel)
    
    // MARK: Views
    private lazy var titleLabel = CustomLabel(
        font: Constants.Fonts.header,
        text: viewModel.title)
    
    private lazy var closeButton: NavigationBarButton = {
        let button = NavigationBarButton(
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
        button.backgroundColor = .lightGray
        button.titleLabel?.font = Constants.Fonts.text
        button.tintColor = .black
        button.setupCornerRadius()
        button.setupHighlightAnimation()
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
    
    private let birthDateLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.birthDate,
        numberOfLines: 2)
    
    private let birthDatePickerView = DatePickerView(type: .birth)
    
    private lazy var birthDateSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.backgroundColor = .lightGray
        switcher.layer.cornerRadius = 16
        switcher.addTarget(
            self,
            action: #selector(birthDateSwitcherChanged),
            for: .valueChanged)
        return switcher
    }()
    
    private let positionLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.position)
    
    private lazy var positionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = pickerViewDelegate
        pickerView.dataSource = pickerViewDataSource
        return pickerView
    }()
    
    private let footLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.foot)
    
    private let footSegmentedControl = GraySegmentedControl(
        items: Constants.Text.SegmentedControlItems.footSegments)
    
    private let heightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.height)
    
    private let heightTextFieldView = DecimalTextFieldView(type: .meters)
    
    private let weightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.weight)
    
    private let weightTextFieldView = DecimalTextFieldView(type: .weight)
    
    private let pageSliderView = PageSliderView()
    
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
    
    private let pageSliderViewDescription = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Text.Descriptions.pageSlider,
        numberOfLines: 2)
    
    private lazy var showTransferDetailsButton: PrimaryButton = {
        let button = PrimaryButton(
            title: Constants.Text.transferDetails,
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showTransferDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var showTestingDetailsButton: PrimaryButton = {
        let button = PrimaryButton(
            title: Constants.Text.testingDetails,
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showTestingDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(title: Constants.Text.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews(
            photoImageView,
            uploadPhotoButton,
            textFieldStackView,
            togglePatronymicFieldDisplayButton,
            toggleNationalTeamFieldDisplayButton,
            birthDateLabel,
            birthDatePickerView,
            birthDateSwitcher,
            positionLabel,
            positionPickerView,
            footLabel,
            footSegmentedControl,
            heightLabel,
            heightTextFieldView,
            weightLabel,
            weightTextFieldView,
            pageSliderView,
            pageSliderViewDescription,
            showTestingDetailsButton,
            showTransferDetailsButton)
        scrollView.prepareForAutoLayout()
        return scrollView
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
        configureUI()
        handlePhotoSelecting()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUploadButtonTitle()
        uploadPhotoButton.setupShadow()
        positionPickerView.setupShadow()
        footSegmentedControl.setupShadow()
        pageSliderView.configure(
            withPages: [
                generalInfoTextViewWithTitle,
                techniqueTextViewWithTitle,
                tacticsTextViewWithTitle,
                qualitiesTextViewWithTitle,
                mentalTextViewWithTitle
            ])
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = Constants.Colors.deepGreen
        view.setKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            closeButton,
            scrollView,
            dividerView,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
    
    private func configureUI() {
        if let player = viewModel.getPlayer() {
            if let photo = player.photoData {
                photoImageView.image = UIImage(data: photo)
            }
            fullNameTextFieldView.set(text: player.fullName)
            if let patronymic = player.patronymic, !patronymic.isEmpty {
                togglePatronymicFieldDisplayButtonTapped(
                    togglePatronymicFieldDisplayButton)
                patronymicTextFieldView.set(text: patronymic)
            }
            citizenshipTextFieldView.set(text: player.citizenship)
            clubTextFieldView.set(text: player.club)
            if let nationalTeam = player.nationalTeam, !nationalTeam.isEmpty {
                toggleNationalTeamFieldDisplayButtonTapped(
                    toggleNationalTeamFieldDisplayButton)
                nationalTeamTextFieldView.set(text: nationalTeam)
            }
            if let birthDate = player.birthDate {
                birthDateSwitcher.isOn.toggle()
                birthDatePickerView.toggleDatePickerEnabled()
                birthDatePickerView.set(date: birthDate)
            }
            let pickerRow = viewModel.getPickerRowBy(title: player.position)
            positionPickerView.selectRow(
                pickerRow ?? 0,
                inComponent: 0,
                animated: true)
            let segmentIndex = viewModel.getSegmentIndexBy(title: player.foot)
            footSegmentedControl.selectedSegmentIndex = segmentIndex ?? 0
            heightTextFieldView.set(text: player.height)
            weightTextFieldView.set(text: player.weight)
            generalInfoTextViewWithTitle.set(text: player.generalInfo)
            techniqueTextViewWithTitle.set(text: player.technique)
            tacticsTextViewWithTitle.set(text: player.tactics)
            qualitiesTextViewWithTitle.set(text: player.qualities)
            mentalTextViewWithTitle.set(text: player.mental)
            viewModel.getTransferDetails()
            viewModel.getTestingDetails()
        }
    }
    
    private func handlePhotoSelecting() {
        viewModel.wasImageChanged = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                if let photo = self.viewModel.selectedPhoto {
                    self.photoImageView.image = photo
                } else {
                    self.setPlaceholderForImageView()
                }
            }
        }
    }
    
    private func updateUploadButtonTitle() {
        let photoPlaceholder = Constants.Images.photoPlaceholder
        let buttonTitle = photoImageView.image != photoPlaceholder
        ? Constants.Text.ButtonTitles.editPhoto
        : Constants.Text.ButtonTitles.uploadPhoto
        uploadPhotoButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setPlaceholderForImageView() {
        photoImageView.image = Constants.Images.photoPlaceholder
    }
    
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.emptyTextFields.title,
                andMessage: Constants.Text.Alerts.emptyTextFields.message)
            present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            present(alertController, animated: true)
        }
        viewModel.wasFullNameContainInvalidChars = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.invalidChars.title,
                andMessage: Constants.Text.Alerts.invalidChars.message)
            present(alertController, animated: true)
        }
        viewModel.wasPositionNotSelected = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.notSelectedPosition.title,
                andMessage: Constants.Text.Alerts.notSelectedPosition.message)
            present(alertController, animated: true)
        }
    }
    
    private func finishChanges() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            delegate.playersWereChanged?()
        }
    }
    
    @objc private func closeButtonTapped() {
        let alertTitle = viewModel.getPlayer() == nil
        ? Constants.Text.ActionSheets.cancelAdding
        : Constants.Text.ActionSheets.cancelEditing
        let alertButtonTitle = viewModel.getPlayer() == nil
        ? Constants.Text.ButtonTitles.continueAdding
        : Constants.Text.ButtonTitles.continueEditing
        let alertController = AlertFactory.getCancelActionSheet(
            withTitle: alertTitle,
            andButtonTitle: alertButtonTitle
        ) { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
        }
        present(alertController, animated: true)
    }
    
    @objc private func uploadPhotoButtonTapped() {
        let photoPlaceholder = Constants.Images.photoPlaceholder
        let isPhotoUploaded = photoImageView.image != photoPlaceholder
        let alertController = AlertFactory.getUploadPhotoActionSheet(
            isPhotoUploaded: isPhotoUploaded) { [weak self] in
                guard let self else { return }
                if UIImagePickerController.isSourceTypeAvailable(
                    .photoLibrary
                ) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = imagePickerDelegate
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .photoLibrary
                    present(imagePicker, animated: true)
                }
            } deleteCompletion: { [weak self] in
                guard let self else { return }
                viewModel.selectedPhoto = nil
            }
        present(alertController, animated: true)
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
            nationalTeamTextFieldView.set(tag: 4)
        } else {
            textFieldStackView.removeArrangedSubview(nationalTeamTextFieldView)
            nationalTeamTextFieldView.removeFromSuperview()
        }
    }
    
    @objc private func birthDateSwitcherChanged() {
        birthDatePickerView.toggleDatePickerEnabled()
    }
    
    @objc private func showTransferDetailsButtonTapped() {
        let transferDetails = ScreenFactory.getTransferDetailsViewController(
            withDelegate: viewModel as TransferDetailsViewControllerDelegate)
        present(transferDetails, animated: true)
    }
    
    @objc private func showTestingDetailsButtonTapped() {
        let careerDetails = ScreenFactory.getTestingDetailsViewController(
            withDelegate: viewModel as TestingDetailsViewControllerDelegate)
        present(careerDetails, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        viewModel.validateInputText(
            [
                fullNameTextFieldView.getInputText(),
                citizenshipTextFieldView.getInputText(),
                clubTextFieldView.getInputText()
            ]
        ) {
            let birthDate = birthDateSwitcher.isOn
            ? birthDatePickerView.getDate()
            : nil
            if let player = viewModel.getPlayer() {
                viewModel.editPlayer(
                    byFullName: player.fullName ?? "",
                    editedFullName: $0[0],
                    patronymic: patronymicTextFieldView.getInputText(),
                    citizenship: $0[1],
                    club: $0[2],
                    nationalTeam: nationalTeamTextFieldView.getInputText(),
                    birthDate: birthDate,
                    position: positionPickerView.selectedRow(inComponent: 0),
                    foot: footSegmentedControl.selectedSegmentIndex,
                    height: heightTextFieldView.getInputText(),
                    weight: weightTextFieldView.getInputText(),
                    generalInfo: generalInfoTextViewWithTitle.getInputText(),
                    technique: techniqueTextViewWithTitle.getInputText(),
                    tactics: tacticsTextViewWithTitle.getInputText(),
                    qualities: qualitiesTextViewWithTitle.getInputText(),
                    mental: mentalTextViewWithTitle.getInputText()
                ) {
                    finishChanges()
                }
            } else {
                viewModel.savePlayer(
                    byFullName: $0[0],
                    patronymic: patronymicTextFieldView.getInputText(),
                    citizenship: $0[1],
                    club: $0[2],
                    nationalTeam: nationalTeamTextFieldView.getInputText(),
                    birthDate: birthDate,
                    position: positionPickerView.selectedRow(inComponent: 0),
                    foot: footSegmentedControl.selectedSegmentIndex,
                    height: heightTextFieldView.getInputText(),
                    weight: weightTextFieldView.getInputText(),
                    generalInfo: generalInfoTextViewWithTitle.getInputText(),
                    technique: techniqueTextViewWithTitle.getInputText(),
                    tactics: tacticsTextViewWithTitle.getInputText(),
                    qualities: qualitiesTextViewWithTitle.getInputText(),
                    mental: mentalTextViewWithTitle.getInputText()
                ) {
                    finishChanges()
                }
            }
        }
    }
}

// MARK: - Layout
private extension EditorViewController {
    
    func setConstraints() {
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
            
            scrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 12),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            photoImageView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            photoImageView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 24),
            photoImageView.trailingAnchor.constraint(
                equalTo: uploadPhotoButton.leadingAnchor,
                constant: -24),
            photoImageView.heightAnchor.constraint(
                equalTo: photoImageView.widthAnchor),
            
            uploadPhotoButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            uploadPhotoButton.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor),
            uploadPhotoButton.heightAnchor.constraint(
                equalTo: birthDatePickerView.heightAnchor),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 16),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
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
            
            birthDateSwitcher.leadingAnchor.constraint(
                equalTo: birthDatePickerView.trailingAnchor,
                constant: 5),
            birthDateSwitcher.centerYAnchor.constraint(
                equalTo: birthDatePickerView.centerYAnchor),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            birthDateLabel.centerYAnchor.constraint(
                equalTo: birthDatePickerView.centerYAnchor,
                constant: 2),
            birthDateLabel.widthAnchor.constraint(equalToConstant: 120),
            
            positionLabel.topAnchor.constraint(
                equalTo: birthDatePickerView.bottomAnchor,
                constant: 24),
            positionLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            
            positionPickerView.topAnchor.constraint(
                equalTo: positionLabel.bottomAnchor,
                constant: 8),
            positionPickerView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            
            footLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 24),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            footSegmentedControl.centerYAnchor.constraint(
                equalTo: footLabel.centerYAnchor,
                constant: -2),
            
            heightLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            heightLabel.centerYAnchor.constraint(
                equalTo: heightTextFieldView.centerYAnchor,
                constant: 1),
            
            heightTextFieldView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 24),
            heightTextFieldView.leadingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor,
                constant: 10),
            
            weightLabel.trailingAnchor.constraint(
                equalTo: weightTextFieldView.leadingAnchor,
                constant: -10),
            weightLabel.centerYAnchor.constraint(
                equalTo: weightTextFieldView.centerYAnchor,
                constant: 1),
            
            weightTextFieldView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 24),
            weightTextFieldView.trailingAnchor.constraint(
                equalTo: footSegmentedControl.trailingAnchor),
            
            pageSliderView.topAnchor.constraint(
                equalTo: heightTextFieldView.bottomAnchor,
                constant: 32),
            pageSliderView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            pageSliderView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor,
                constant: 20),
            pageSliderView.heightAnchor.constraint(equalToConstant: 140),
            
            pageSliderViewDescription.topAnchor.constraint(
                equalTo: pageSliderView.bottomAnchor,
                constant: -16),
            pageSliderViewDescription.leadingAnchor.constraint(
                equalTo: pageSliderView.leadingAnchor,
                constant: 5),
            pageSliderViewDescription.trailingAnchor.constraint(
                equalTo: pageSliderView.trailingAnchor,
                constant: -20),
            
            showTransferDetailsButton.topAnchor.constraint(
                equalTo: pageSliderViewDescription.bottomAnchor,
                constant: 24),
            showTransferDetailsButton.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            showTransferDetailsButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            showTestingDetailsButton.topAnchor.constraint(
                equalTo: showTransferDetailsButton.bottomAnchor,
                constant: 16),
            showTestingDetailsButton.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 16),
            showTestingDetailsButton.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor,
                constant: -24),
            showTestingDetailsButton.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            dividerView.topAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
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
