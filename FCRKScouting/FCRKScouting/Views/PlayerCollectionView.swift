//
//  PlayerCollectionView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCollectionView: UICollectionView {

    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
        registerViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
    private func registerViews() {
        register(
            DateHeaderView.self,
            forSupplementaryViewOfKind: Self.elementKindSectionHeader,
            withReuseIdentifier: DateHeaderView.identifier)
        register(
            PlayerCollectionViewCell.self,
            forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier)
    }
}
