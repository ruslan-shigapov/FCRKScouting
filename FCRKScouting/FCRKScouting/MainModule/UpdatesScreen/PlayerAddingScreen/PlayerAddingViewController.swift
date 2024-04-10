//
//  PlayerAddingViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class PlayerAddingViewController: UIViewController {
    
    // MARK: Private Properties 
    private let viewModel: PlayerAddingViewModelProtocol
    
    // MARK: Views
    private let titleLabel = HeaderLabel(
        title: Constants.Text.ScreenTitles.addPlayer)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let photoImageView = PhotoImageView()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(Constants.Text.ButtonTitles.uploadPhoto, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let fullNameTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    private let patronymicTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.patronymic,
        type: .name,
        tag: 2)
    private let citizenshipTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.citizenship,
        type: .name,
        tag: 3)
    private let clubTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.club,
        type: .name,
        tag: 4)
    private let nationalTeamTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.nationalTeam,
        type: .name,
        tag: 5)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextFieldView,
            patronymicTextFieldView,
            citizenshipTextFieldView,
            clubTextFieldView,
            nationalTeamTextFieldView
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.birthDate
        return label
    }()
    
    private let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.position
        return label
    }()
    
    private lazy var positionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.layer.cornerRadius = 12
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private let footLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.foot
        return label
    }()
    
    private let footSegmentedControl = GraySegmentedControl(
        items: Constants.Text.SegmentedControlItems.footSegments)
    
    private let generalInfoTextViewWithTitle = TextViewWithTitle(
        title: "Общая информация:")
    private let techniqueTextViewWithTitle = TextViewWithTitle(
        title: "Техника:")
    private let tacticsTextViewWithTitle = TextViewWithTitle(
        title: "Тактика:")
    private let qualitiesTextViewWithTitle = TextViewWithTitle(
        title: "Физ. качества:")
    private let mentalTextViewWithTitle = TextViewWithTitle(
        title: "Ментальность:")
    
    private lazy var textViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            generalInfoTextViewWithTitle,
            techniqueTextViewWithTitle,
            tacticsTextViewWithTitle,
            qualitiesTextViewWithTitle,
            mentalTextViewWithTitle
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(photoImageView)
        scrollView.addSubview(addPhotoButton)
        scrollView.addSubview(textFieldStackView)
        scrollView.addSubview(birthDateLabel)
        scrollView.addSubview(birthDatePicker)
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(positionPickerView)
        scrollView.addSubview(footLabel)
        scrollView.addSubview(footSegmentedControl)
        scrollView.addSubview(textViewStackView)
        return scrollView
    }()
    
    // MARK: Initialize
    init(viewModel: PlayerAddingViewModelProtocol) {
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
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(verticalScrollView)
        setConstraints()
    }
    
    @objc private func cancelButtonTapped() {
        let cancelAlert = AlertFactory.getCancelAlert(
            withTitle: Constants.Text.ActionSheets.cancelAdding
        ) { [weak self] in
            self?.dismiss(animated: true)
        }
        present(cancelAlert, animated: true)
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
        let titleLabel = UILabel()
        titleLabel.text = viewModel.getTitleFor(pickerRow: row)
        titleLabel.font = Constants.Fonts.text
        titleLabel.textAlignment = .center
        return titleLabel
    }
}

// MARK: - Layout
private extension PlayerAddingViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        verticalScrollView.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.bottomAnchor.constraint(
                equalTo: closeButton.bottomAnchor),
            
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            verticalScrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 12),
            verticalScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            verticalScrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            verticalScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            photoImageView.topAnchor.constraint(
                equalTo: verticalScrollView.topAnchor),
            photoImageView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            
            addPhotoButton.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            addPhotoButton.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 12),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            
            birthDateLabel.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            birthDateLabel.centerYAnchor.constraint(
                equalTo: birthDatePicker.centerYAnchor),
            
            birthDatePicker.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 12),
            birthDatePicker.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            positionLabel.topAnchor.constraint(
                equalTo: birthDatePicker.bottomAnchor,
                constant: 12),
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
            footLabel.centerYAnchor.constraint(
                equalTo: footSegmentedControl.centerYAnchor),
            
            footSegmentedControl.topAnchor.constraint(
                equalTo: positionPickerView.bottomAnchor,
                constant: 12),
            footSegmentedControl.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor),
            
            textViewStackView.topAnchor.constraint(
                equalTo: footSegmentedControl.bottomAnchor,
                constant: 12),
            textViewStackView.leadingAnchor.constraint(
                equalTo: verticalScrollView.leadingAnchor,
                constant: 24),
            textViewStackView.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            textViewStackView.bottomAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor,
                constant: -24)
        ])
    }
}
