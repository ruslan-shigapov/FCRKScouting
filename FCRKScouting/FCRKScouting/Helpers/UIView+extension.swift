//
//  UIView+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import UIKit

extension UIView {
    
    func setCustomCornerRadius() {
        layer.cornerRadius = 12
    }
    
    func setCustomShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 10, height: -10)
    }
    
    func setGrayRoundedGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.gray.withAlphaComponent(0.7).cgColor,
            UIColor.gray.withAlphaComponent(0.1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func prepareForAutoLayout() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // TODO: remove to controller
    func setCustomAccentAndGreenGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.accent.withAlphaComponent(0.7).cgColor,
            UIColor.systemGreen.withAlphaComponent(0.4).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
