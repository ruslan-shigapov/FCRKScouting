//
//  UpdatesCollectionDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class PlayerCollectionViewDelegate: NSObject,
                                          UICollectionViewDelegateFlowLayout {
    
    private let viewModel: PlayerCollectionViewProtocol
    private let navigationController: UINavigationController?
    
    init(
        viewModel: PlayerCollectionViewProtocol,
        navigationController: UINavigationController?
    ) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        viewModel is UpdatesViewModel
        ? CGSize(width: collectionView.bounds.width, height: 30)
        : .zero
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
        guard viewModel is UpdatesViewModel else {
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        }
        return section == (collectionView.numberOfSections - 1)
        ? UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        : .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let playerViewModel = viewModel.getPlayerViewModel(
            for: viewModel.getPlayer(at: indexPath)
        ) else {
            return
        }
        let playerVC = ScreenFactory.getPlayerViewController(
            withDelegate: viewModel as PlayerViewControllerDelegate,
            andViewModel: playerViewModel)
        navigationController?.pushViewController(playerVC, animated: true)
    }
}
