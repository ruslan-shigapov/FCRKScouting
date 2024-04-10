//
//  TextViewWithTitle.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class TextViewWithTitle: UIView {

    private let titleLabel = UILabel()
    
    private let roundedTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 12
        return textView
    }()

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(roundedTextView)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            roundedTextView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            roundedTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedTextView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
}
