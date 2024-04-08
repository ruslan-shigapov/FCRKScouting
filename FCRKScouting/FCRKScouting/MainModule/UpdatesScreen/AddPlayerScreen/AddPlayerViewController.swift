//
//  AddPlayerViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class AddPlayerViewController: UIViewController {
    
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
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        // TODO: continue to implement
        return scrollView
    }()
    
    private let photoImageView = PhotoImageView()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Загрузить фото", for: .normal)
        button.layer.cornerRadius = 12
        return button
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
        setConstraints()
    }
    
    @objc private func cancelButtonTapped() {
        showCancelAlert(
            withTitle: Constants.Text.ActionSheets.cancelAdding
        ) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Alert Controllers
private extension AddPlayerViewController {
    
    func showCancelAlert(
        withTitle title: String,
        completion: @escaping () -> Void
    ) {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet)
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16, weight: .medium)
                ]),
            forKey: "attributedTitle")
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancelAdding,
            style: .destructive) { _ in
                completion()
            }
        let continueAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.continueAdding,
            style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
}

// MARK: - Layout
private extension AddPlayerViewController {
    
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
        ])
    }
}
