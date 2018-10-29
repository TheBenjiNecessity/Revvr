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
        // This sizeForItemAt method simply sizes reviews with comments to be full width while
        // reviews without comments should be square and a third the width of the collection view.
        let collectionViewWidth = collectionView.bounds.size.width
        guard let review = models?[indexPath.row] as? Review else {
            return CGSize(width: 0, height: 0)
        }

        if review.comment != nil {
            let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! ReviewWithCommentCollectionViewCell
            return CGSize(width: collectionViewWidth, height: cell.getMinHeight(collectionViewWidth: collectionViewWidth))
        } else {
            return CGSize(width: collectionViewWidth / 3, height: collectionViewWidth / 3)
        }
    }
}

class ReviewsCollectionViewController: UICollectionViewController {
    // Using 'Any' here as the model may be preceded by user or reviewable models before the list of reviews
    var models: [Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO this is wrong (this should be happening in a subclass)
        if let user = SessionService.shared.user {
            ReviewAPIService.shared.listByFollowings(id: user.id!).then { reviews in
                self.models = reviews //TODO: this should be a property with refresh()
                self.refresh()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let review = models![indexPath.row] as! Review
        let identifier = (review.comment != nil) ? reviewWithCommentCVCId : reviewWithoutCommentCVCId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ReviewCollectionViewCell
        
        cell.setReview(review: review)
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        
        return cell
    }
    
    func refresh() {
        guard let models = models else {
            return
        }
        
        var finalModels: [Any] = []
        var groupedReviews: [Review] = []
        var smallArray: [Review] = []
        
        for model in models {
            if case let review as Review = model {
                // Group reviews based on reviews having or not having a comment.
                // Reviews without comments are grouped in blocks of three.
                if review.comment != nil {
                    groupedReviews.append(review)
                } else {
                    smallArray.append(review)
                    if smallArray.count == 3 {
                        groupedReviews += smallArray
                        smallArray.removeAll()
                    }
                }
            } else {
                // For any models that aren't reviews then put them at the beginning
                finalModels.append(model)
            }
        }
        
        // Set reviews to grouped formation (not forgetting to add remainder of smallArray
        // if smallArray had fewer than 3 elements by the end).
        self.models = finalModels + groupedReviews as [Any] + smallArray as [Any]
        
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
