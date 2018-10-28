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

fileprivate let paddingConstraint: CGFloat = CGFloat(5.0)
fileprivate let spacingConstraint: CGFloat = CGFloat(8.0)

class ReviewWithCommentCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ReviewWithCommentCollectionViewCellIdentifier"
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reviewableLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    /**
        Sets up the cell with the given review
        - parameter review: the review
     */
    func setReview(review: Review) {
        // It shouldn't be possible for the review comment to be nil so this should be okay
        commentLabel?.text = review.comment!
        reviewableLabel?.text = review.reviewable.title
        usernameLabel?.text = review.appUser.handle
        
        //TODO: add setup for images
    }
    
    /**
        Returns the minimum height that the cell should be based on it's comment label. If the comment is short then
        this function will return the a height based on the profile picture image view height plus the height of the
        reviewable image view along with spacing between elements. If the comment is long then this function will return
        the height of the username label plus the height of the reviewable name label plus the computed height of the
        comment label along with spacing between elements.
        - parameter collectionViewWidth: the full width of the collection view (used for computing label heights)
     */
    func getMinHeight(collectionViewWidth: CGFloat) -> CGFloat {
        let ppWidth = profilePictureImageView.frame.size.width
        let eWidth = emojiImageView.frame.size.width
        // The width of each label is computed using the full collection view width minus the width of the image views
        // that surround it.
        let lblWidth = collectionViewWidth - (paddingConstraint + ppWidth + eWidth + paddingConstraint)//TODO magic numbers are gross
        
        // Compute the height of all the labels based on their widths and text contents
        let commentLblHeight = commentLabel.text?.height(withConstrainedWidth: CGFloat(lblWidth), font: commentLabel.font)
        let reviewableLblHeight = reviewableLabel.text?.height(withConstrainedWidth: CGFloat(lblWidth), font: reviewableLabel.font)
        let usernameLblHeight = usernameLabel.text?.height(withConstrainedWidth: CGFloat(lblWidth), font: usernameLabel.font)
        let lblHeight = paddingConstraint + reviewableLblHeight! + usernameLblHeight! + commentLblHeight! + paddingConstraint
        
        // Compute the minimum height of the collection view cell which is the height of the profile picture image view
        // plus the height of the reviewable image view along with spacing between elements.
        let profilePictureHeight = profilePictureImageView.frame.size.height
        let reviewableImageHeight = reviewableImageView.frame.size.height
        let minHeight = CGFloat(paddingConstraint + profilePictureHeight + spacingConstraint + reviewableImageHeight + paddingConstraint)
        
        // The final height is the tallest between the labels and the imageviews.
        return max(minHeight, lblHeight)
    }
}
