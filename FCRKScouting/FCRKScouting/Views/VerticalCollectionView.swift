//
//  VerticalCollectionView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class VerticalCollectionView: UICollectionView {

    override init(
        frame: CGRect,
        collectionViewLayout layout: UICollectionViewLayout
    ) {
        super.init(
            frame: frame,
            collectionViewLayout: UICollectionViewFlowLayout())
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
    }
}
