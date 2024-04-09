//
//  PlayerAddingViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class PlayerAddingViewController: UIViewController {
    
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
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        // TODO: continue to implement
        return scrollView
    }()

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
        view.addSubview(photoImageView)
        view.addSubview(addPhotoButton)
        view.addSubview(fullNameTextField)
        view.addSubview(patronymicTextField)
        view.addSubview(positionPickerView)
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

// MARK: - Picker View Delegate
extension PlayerAddingViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let positions = ["Вратарь", "Защитник", "Нападающий"]
        return positions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return
    }
}

// MARK: - Picker View Data Source
extension PlayerAddingViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        3
    }
}

// MARK: - Layout
private extension PlayerAddingViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor),
            
            closeButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            photoImageView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 32),
            photoImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
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
                equalTo: view.leadingAnchor,
                constant: 24),
            
            patronymicTextField.topAnchor.constraint(
                equalTo: fullNameTextField.bottomAnchor,
                constant: 24),
            patronymicTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            positionPickerView.topAnchor.constraint(
                equalTo: patronymicTextField.bottomAnchor,
                constant: 24),
            positionPickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            positionPickerView.heightAnchor.constraint(equalToConstant: 96),
            positionPickerView.widthAnchor.constraint(equalTo: fullNameTextField.widthAnchor)
        ])
    }
}
