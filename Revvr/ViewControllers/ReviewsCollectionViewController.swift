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
        let collectionViewWidth = collectionView.bounds.size.width - 2 // '- 2' for inset spacing
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! ReviewCollectionViewCell
        
        return CGSize(width: cell.getMinWidth(collectionViewWidth: collectionViewWidth),
                      height: cell.getMinHeight(collectionViewWidth: collectionViewWidth))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}

class ReviewsCollectionViewController: UICollectionViewController, UserDetailsViewDelegate {
    var segueIdentifier = "ReviewDetailSegueIdentifier"
    var reviews: [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewViewNib = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        self.collectionView!.register(reviewViewNib, forCellWithReuseIdentifier: reviewWithoutCommentCVCId)
        
        let reviewWithCommentViewNib = UINib(nibName: "ReviewWithCommentCollectionViewCell", bundle: nil)
        self.collectionView!.register(reviewWithCommentViewNib, forCellWithReuseIdentifier: reviewWithCommentCVCId)
        
        (self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
        
        self.collectionView!.refreshControl = UIRefreshControl()
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
        cell.userDetailsView.delegate = self
        cell.userDetailsView.setImage(height: 35)
        cell.userDetailsView.shouldAllowTap = true
        
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
    
    func showLoadingIndicator(show: Bool) {
        if show {
            self.collectionView!.refreshControl?.beginRefreshing()
        } else {
            self.collectionView!.refreshControl?.endRefreshing()
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        
        self.performSegue(withIdentifier: segueIdentifier, sender: review)
    }
    
    // MARK: Navigation methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rtvc = segue.destination as? ReviewTableViewController,
            let review = sender as? Review {
            rtvc.review = review
        }
    }
    
    func didTap(with user: AppUser) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let uwrcvc = storyboard.instantiateViewController(withIdentifier: "UserWithReviewsCollectionViewController") as! UserWithReviewsCollectionViewController
        uwrcvc.user = user
        self.navigationController?.pushViewController(uwrcvc, animated: true)
    }
}
