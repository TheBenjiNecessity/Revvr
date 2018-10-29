//
//  ReviewWithoutCommentCollectionViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

fileprivate let shadowRadius = CGFloat(2.0)
fileprivate let shadowOpacity = Float(0.5)
fileprivate let shadowOffset = CGSize(width: 0, height: 1)
fileprivate let masksToBounds = false

class ReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reviewableLabel: UILabel!
    
    func setReview(review: Review) {
        usernameLabel.text = review.appUser.handle
        reviewableLabel.text = review.reviewable.title
        
        usernameLabel.layer.shadowRadius = shadowRadius
        usernameLabel.layer.shadowOpacity = shadowOpacity
        usernameLabel.layer.shadowOffset = shadowOffset
        usernameLabel.layer.masksToBounds = masksToBounds
        
        reviewableLabel.layer.shadowRadius = shadowRadius
        reviewableLabel.layer.shadowOpacity = shadowOpacity
        reviewableLabel.layer.shadowOffset = shadowOffset
        reviewableLabel.layer.masksToBounds = masksToBounds
        
        //TODO images
    }
}
