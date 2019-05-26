//
//  ReviewWithoutCommentCollectionViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

fileprivate let bottomPadding = CGFloat(80.0)
fileprivate let paddingConstraint: CGFloat = CGFloat(5.0)

class ReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgReviewableImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reviewableLabel: UILabel!
    
    var imageSize = CGSize.zero
    
    func setReview(review: Review) {
        usernameLabel.attributedText = NSAttributedString.attributedStringFor(user: review.appUser, of: CGFloat(15.0))
        reviewableLabel.text = review.reviewable.title
        
        if let imageUrl = review.reviewable.titleImageUrl {
            self.bgReviewableImageView?.image = UIImage.image(from: imageUrl)
        }
        
        emojiImageView?.image = UIImage(named: review.emojis + "Emoji")
        
        imageSize = bgReviewableImageView?.image!.size ?? CGSize.zero
        
        //TODO: profile picture
    }
    
    func getMinHeight(collectionViewWidth: CGFloat) -> CGFloat {
        let cellWidth = self.getMinWidth(collectionViewWidth: collectionViewWidth)
        let profilePictureHeight = profilePictureImageView.frame.size.height
        return (cellWidth * (imageSize.height / imageSize.width)) + paddingConstraint + profilePictureHeight + paddingConstraint
    }
    
    func getMinWidth(collectionViewWidth: CGFloat) -> CGFloat {
        return (collectionViewWidth / 2) - 3
    }
}
