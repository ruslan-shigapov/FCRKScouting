//
//  UpdatesCollectionDataSource.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class UpdatesCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel: UpdatesViewModelProtocol
    
    init(viewModel: UpdatesViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItemsIn(section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PlayerCell.self),
            for: indexPath) as? PlayerCell
        let currentPlayer = viewModel.getPlayer(at: indexPath)
        cell?.viewModel = viewModel.getPlayerCellViewModel(for: currentPlayer)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: DateHeaderView.self),
            for: indexPath) as? DateHeaderView
        let sectionDate = viewModel.sortedDates[indexPath.section]
        headerView?.configure(withDate: viewModel.format(date: sectionDate))
        return headerView ?? UICollectionReusableView()
    }
}
