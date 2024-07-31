//
//  SearchCollectionDataSource.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.07.2024.
//

import UIKit

final class SearchCollectionDataSource: NSObject, UICollectionViewDataSource {

    private let viewModel: SearchViewModelProtocol
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: PlayerCollectionViewCell.self),
            for: indexPath) as? PlayerCollectionViewCell
        let currentPlayer = viewModel.getPlayer(at: indexPath)
        cell?.viewModel = viewModel.getPlayerCellViewModel(for: currentPlayer)
        return cell ?? UICollectionViewCell()
    }
}
