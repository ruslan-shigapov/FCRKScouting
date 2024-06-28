//
//  UIView+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import UIKit

extension UIView {
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    func setKeyboardDismissTap() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func prepareForAutoLayout() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setCommonCornerRadius() {
        layer.cornerRadius = 12
    }
    
    func setCommonShadow() {
        clipsToBounds = false
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius).cgPath
    }
    
    func setupCommonGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.accent.withAlphaComponent(0.7).cgColor,
            UIColor.systemGreen.withAlphaComponent(0.5).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setCommonBorder() {
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.naturalGold?.cgColor
    }
}
