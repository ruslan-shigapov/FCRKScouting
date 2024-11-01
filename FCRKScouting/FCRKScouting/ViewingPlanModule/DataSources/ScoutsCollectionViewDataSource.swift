//
//  ScoutsCollectionViewDataSource.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.10.2024.
//

import UIKit

final class ScoutsCollectionViewDataSource: NSObject,
                                                 UICollectionViewDataSource {
    
    private let viewModel: TournamentViewModelProtocol
    
    init(viewModel: TournamentViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfResponsibleOnes()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: ResponsibleCollectionViewCell.self),
            for: indexPath) as? ResponsibleCollectionViewCell
        cell?.viewModel = viewModel.getResponsibleCellViewModel(at: indexPath)
        cell?.delegate = viewModel as ResponsibleCellDelegate
        cell?.configure(withDeletingModeState: viewModel.isDeletingModeActive)
        return cell ?? UICollectionViewCell()
    }
}
