//
//  UserWithReviewsCollectionViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-28.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

// This page should have a user view at the top and sections of tableviews underneath
// those table view would be:
// - the user's reviews
// - the reviews of the user's followings

import UIKit

class UserWithReviewsCollectionViewController: ReviewsCollectionViewController {
    var user = AppUser() {
        didSet {
            self.title = "\(user.firstName) \(user.lastName)"
            ReviewAPIService.shared.listByUser(id: user.id!).then { reviews in
                self.reviews = reviews
                self.refresh()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let userCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                         withReuseIdentifier: UserCollectionReusableView.reuseIdentifier,
                                                                                         for: indexPath) as! UserCollectionReusableView
        userCollectionReusableView.setUser(user: user)
        
        userCollectionReusableView.frame = CGRect(x: 0.0, y: 0.0, width: collectionView.frame.size.width, height: UserCollectionReusableView.viewHeight)

        return userCollectionReusableView
    }
}
