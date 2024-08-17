//
//  UpdatesCollectionDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class UpdatesCollectionDelegate: NSObject,
                                       UICollectionViewDelegateFlowLayout {
    
    private let navigationController: UINavigationController?
    private let viewModel: UpdatesViewModelProtocol
    
    init(
        navigationController: UINavigationController?,
        viewModel: UpdatesViewModelProtocol
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 30)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 32, height: 90)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == (collectionView.numberOfSections - 1) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let currentPlayer = viewModel.getPlayer(at: indexPath) else {
            return
        }
        let playerVC = ScreenFactory.getPlayerViewController(
            withDelegate: viewModel as PlayerViewControllerDelegate,
            andPlayer: currentPlayer)
        navigationController?.pushViewController(playerVC, animated: true)
    }
}
