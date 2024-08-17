//
//  UIButton+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 02.07.2024.
//

import UIKit

extension UIButton {
    
    private func animateButton(scaleX: CGFloat, y: CGFloat) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [.beginFromCurrentState, .allowUserInteraction]
        ) {
            self.transform = CGAffineTransform(scaleX: scaleX, y: y)
        }
    }
    
    @objc private func handleHighlight() {
        animateButton(scaleX: 0.94, y: 0.94)
    }
    
    @objc private func handleUnhighlight() {
        animateButton(scaleX: 1.0, y: 1.0)
    }
    
    func setupHighlightAnimation() {
        addTarget(
            self,
            action: #selector(handleHighlight),
            for: [.touchDown, .touchDragEnter])
        addTarget(
            self,
            action: #selector(handleUnhighlight),
            for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
}
