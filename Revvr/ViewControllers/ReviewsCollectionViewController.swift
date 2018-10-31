//
//  ReviewsCollectionViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

fileprivate let reviewWithCommentCVCId = "ReviewWithCommentCollectionViewCellIdentifier"
fileprivate let reviewWithoutCommentCVCId = "ReviewWithoutCommentCollectionViewCellIdentifier"

extension ReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let review = reviews[indexPath.row]
        let collectionViewWidth = collectionView.bounds.size.width

        if review.comment != nil {
            //TODO there must be a better way
            let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! ReviewWithCommentCollectionViewCell
            return CGSize(width: collectionViewWidth, height: cell.getMinHeight(collectionViewWidth: collectionViewWidth))
        } else {
            return CGSize(width: collectionViewWidth / 3, height: collectionViewWidth / 3)
        }
    }
}

class ReviewsCollectionViewController: UICollectionViewController {
    var reviews: [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewViewNib = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        self.collectionView!.register(reviewViewNib, forCellWithReuseIdentifier: reviewWithoutCommentCVCId)
        
        let reviewWithCommentViewNib = UINib(nibName: "ReviewWithCommentCollectionViewCell", bundle: nil)
        self.collectionView!.register(reviewWithCommentViewNib, forCellWithReuseIdentifier: reviewWithCommentCVCId)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let review = reviews[indexPath.row]
        let identifier = (review.comment != nil) ? reviewWithCommentCVCId : reviewWithoutCommentCVCId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ReviewCollectionViewCell
        
        cell.setReview(review: review)
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        
        return cell
    }
    
    func refresh() {
        // Group reviews based on reviews having or not having a comment.
        // Reviews without comments are grouped in blocks of three.
        var groupedReviews: [Review] = []
        var smallArray: [Review] = []
        
        for review in reviews {
            if review.comment != nil {
                groupedReviews.append(review)
            } else {
                smallArray.append(review)
                if smallArray.count == 3 {
                    groupedReviews += smallArray
                    smallArray.removeAll()
                }
            }
        }
        
        // set reviews to grouped formation (not forgetting to add remainder of smallArray
        // if smallArray had fewer than 3 elements by the end).
        reviews = groupedReviews + smallArray
        
        // I may also want to group by reviewable where all reviews without comments with the same reviewable should
        // use the same cell
        
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
