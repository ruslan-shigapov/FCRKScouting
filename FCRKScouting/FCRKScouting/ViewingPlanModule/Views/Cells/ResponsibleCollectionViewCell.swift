//
//  ResponsibleCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.10.2024.
//

import UIKit

final class ResponsibleCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private let responsibleOneLabel = DefaultTextLabel()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Images.ButtonImages.xMark, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(
            self,
            action: #selector(deleteButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [responsibleOneLabel, deleteButton])
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: Public Properties
    weak var delegate: ResponsibleCellDelegate?
    
    var viewModel: ResponsibleCellViewModelProtocol? {
        didSet {
            responsibleOneLabel.text = viewModel?.scoutName
        }
    }
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        addSubview(containerStackView)
        setupCornerRadius()
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(
                equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10),
            containerStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            containerStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 12),
            deleteButton.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    @objc private func deleteButtonTapped() {
        guard let viewModel else { return }
        delegate?.responsibleOneWasDeleted?(viewModel.getResponsibleOne())
    }
    
    // MARK: Public Methods
    func configure(withDeletingModeState isActive: Bool) {
        deleteButton.isHidden = !isActive
    }
}
