//
//  ReviewableWithReviewsCollectionViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-31.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewableWithReviewsCollectionViewController: ReviewsCollectionViewController {
    var reviewable: Reviewable? {
        didSet {
            if let reviewable = self.reviewable {
                ReviewAPIService.shared.listByReviewable(id: reviewable.ID!).then { reviews in
                    self.reviews = reviews
                    self.refresh()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addReview))
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let reviewableCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                         withReuseIdentifier: ReviewableCollectionReusableView.reuseIdentifier,
                                                                                         for: indexPath) as! ReviewableCollectionReusableView
        reviewableCollectionReusableView.frame = CGRect(x: 0.0, y: 0.0, width: collectionView.frame.size.width, height: ReviewableCollectionReusableView.viewHeight)
        
        reviewableCollectionReusableView.setReviewable(reviewable: reviewable!)
        
        return reviewableCollectionReusableView
    }
    
    // MARK: Callbacks
    
    @objc func addReview() {
       self.performSegue(withIdentifier: CreateReviewViewController.modalSegueIdentifier, sender: reviewable)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reviewable = sender as? Reviewable {
            let nav = segue.destination as! UINavigationController
            let cvc = nav.topViewController as! CreateReviewViewController
            cvc.setReviewable(reviewable: reviewable)
        }
    }
}
