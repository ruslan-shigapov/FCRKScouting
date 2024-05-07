//
//  EditButton.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 27.03.2024.
//

import UIKit

// TODO: возможно обойтись без нее или как-то оптимизировать..?
final class EditButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .lightGray
        setImage(Constants.Images.ButtonImages.edit, for: .normal)
        setCustomCornerRadius()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
