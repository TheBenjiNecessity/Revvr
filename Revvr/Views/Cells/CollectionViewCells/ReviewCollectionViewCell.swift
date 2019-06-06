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
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var reviewableLabel: UILabel!
    @IBOutlet weak var userDetailsView: UserDetailsView!
    
    var imageSize = CGSize.zero
    
    func setReview(review: Review) {
        userDetailsView.setUserDetails(user: review.appUser)
        reviewableLabel.text = review.reviewable.title
        
        if let imageUrl = review.reviewable.titleImageUrl {
            self.bgReviewableImageView?.image = UIImage.image(from: imageUrl)
        }
        
        emojiImageView?.image = UIImage(named: review.emojis + "Emoji")
        
        imageSize = bgReviewableImageView?.image!.size ?? CGSize.zero
    }
    
    func getMinHeight(collectionViewWidth: CGFloat) -> CGFloat {
        let cellWidth = self.getMinWidth(collectionViewWidth: collectionViewWidth)
        return (cellWidth * (imageSize.height / imageSize.width)) + paddingConstraint + 36 + paddingConstraint
    }
    
    func getMinWidth(collectionViewWidth: CGFloat) -> CGFloat {
        return (collectionViewWidth / 2) - 3
    }
}
