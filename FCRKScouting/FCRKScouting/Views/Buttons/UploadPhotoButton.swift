//
//  UploadPhotoButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 27.06.2024.
//

import UIKit

final class UploadPhotoButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.beginFromCurrentState, .allowUserInteraction]
            ) {
                self.transform = self.isHighlighted
                ? .init(scaleX: 0.94, y: 0.94)
                : .identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCommonShadow()
    }
    
    private func setupUI() {
        backgroundColor = .white
        tintColor = .label
        setTitle(Constants.Text.ButtonTitles.uploadPhoto, for: .normal)
        setCommonCornerRadius()
        widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
