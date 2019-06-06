//
//  ReviewWithCommentCollectionViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
//  A UICollectionViewCell subclass acting as the controller for setting up the information on a collection view cell
//  for a review with a comment.

import UIKit

fileprivate let shadowRadius = CGFloat(2.0)
fileprivate let shadowOpacity = Float(0.5)
fileprivate let shadowOffset = CGSize(width: 0, height: 1)
fileprivate let masksToBounds = false

fileprivate let paddingConstraint: CGFloat = CGFloat(5.0)
fileprivate let spacingConstraint: CGFloat = CGFloat(8.0)
fileprivate let bottomSpacingConstraint: CGFloat = CGFloat(24.0)
fileprivate let minHeight: CGFloat = CGFloat(120.0)

class ReviewWithCommentCollectionViewCell: ReviewCollectionViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var reviewableImageView: UIImageView!
    
    override func setReview(review: Review) {
        super.setReview(review: review)
        
        // It shouldn't be possible for the review comment to be nil so this should be okay
        commentLabel?.text = review.comment!
    }
    
    override func getMinHeight(collectionViewWidth: CGFloat) -> CGFloat {
        let ppWidth = CGFloat(35)
        let lblWidth = collectionViewWidth - (paddingConstraint + ppWidth + paddingConstraint)
        let reviewableImageHeight = reviewableImageView.frame.size.height
        
        // Compute the height of the username and comment labels based on their widths and text contents
        let profilePictureHeight = CGFloat(35)
        let commentLblHeight = commentLabel.text?.height(withConstrainedWidth: CGFloat(lblWidth), font: commentLabel.font)
        let lblHeight = reviewableImageHeight + paddingConstraint + profilePictureHeight + paddingConstraint + commentLblHeight! + bottomSpacingConstraint

        return max(minHeight, lblHeight)
    }
    
    override func getMinWidth(collectionViewWidth: CGFloat) -> CGFloat {
        return collectionViewWidth
    }
}
