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
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.ScreenTitles.addPlayer
        label.font = Constants.Fonts.header
        label.textColor = .white
        return label
    }()
    
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
        button.setTitle("Загрузить фото", for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let fullNameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    
    private let patronymicTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.patronymic,
        type: .name,
        tag: 2)
    
    private lazy var positionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.layer.cornerRadius = 12
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(photoImageView)
        scrollView.addSubview(addPhotoButton)
        scrollView.addSubview(fullNameTextField)
        scrollView.addSubview(patronymicTextField)
        scrollView.addSubview(positionPickerView)
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
        view.addSubview(contentScrollView)
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
        titleLabel.font = .systemFont(ofSize: 18)
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
        contentScrollView.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor),
            
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            contentScrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor),
            contentScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            contentScrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            photoImageView.topAnchor.constraint(
                equalTo: contentScrollView.topAnchor,
                constant: 24),
            photoImageView.leadingAnchor.constraint(
                equalTo: contentScrollView.leadingAnchor,
                constant: 24),
            
            addPhotoButton.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            addPhotoButton.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            fullNameTextField.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 24),
            fullNameTextField.leadingAnchor.constraint(
                equalTo: contentScrollView.leadingAnchor,
                constant: 24),
            
            patronymicTextField.topAnchor.constraint(
                equalTo: fullNameTextField.bottomAnchor,
                constant: 24),
            patronymicTextField.leadingAnchor.constraint(
                equalTo: contentScrollView.leadingAnchor,
                constant: 24),
            
            positionPickerView.topAnchor.constraint(
                equalTo: patronymicTextField.bottomAnchor,
                constant: 24),
            positionPickerView.leadingAnchor.constraint(
                equalTo: contentScrollView.leadingAnchor,
                constant: 24),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(
                equalTo: fullNameTextField.widthAnchor)
        ])
    }
}
