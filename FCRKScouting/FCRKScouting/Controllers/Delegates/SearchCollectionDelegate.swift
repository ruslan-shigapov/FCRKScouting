//
//  SearchCollectionDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.07.2024.
//

import UIKit

final class SearchCollectionDelegate: NSObject,
                                      UICollectionViewDelegateFlowLayout {
    
    private let navigationController: UINavigationController?
    private let viewModel: SearchViewModelProtocol
    
    init(
        navigationController: UINavigationController?,
        viewModel: SearchViewModelProtocol
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
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
        UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 0)
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
