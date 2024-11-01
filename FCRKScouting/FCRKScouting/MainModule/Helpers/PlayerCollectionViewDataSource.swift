//
//  UpdatesCollectionDataSource.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class PlayerCollectionViewDataSource: NSObject,
                                            UICollectionViewDataSource {
    
    private let viewModel: PlayerCollectionViewProtocol
    
    init(viewModel: PlayerCollectionViewProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItems(in: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlayerCollectionViewCell.identifier,
            for: indexPath)
        guard let playerCell = cell as? PlayerCollectionViewCell else {
            return UICollectionViewCell()
        }
        playerCell.viewModel = viewModel.getPlayerCellViewModel(
            for: viewModel.getPlayer(at: indexPath))
        return playerCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let viewModel = viewModel as? UpdatesViewModel else {
            return UICollectionReusableView()
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: DateHeaderView.self),
            for: indexPath)
        guard let dateHeaderView = headerView as? DateHeaderView else {
            return UICollectionReusableView()
        }
        dateHeaderView.configure(
            withDate: viewModel.getFormattedDate(at: indexPath.section))
        return dateHeaderView
    }
}
