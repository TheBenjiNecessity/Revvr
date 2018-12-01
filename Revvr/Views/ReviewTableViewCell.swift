//
//  ReviewTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewTableViewCellIdentifier"
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var reviewableDetailsLabel: UILabel!
    @IBOutlet weak var reviewCommentLabel: UILabel!
    @IBOutlet weak var emojiImageView: UIImageView!
    
    func setReview(review: Review) {
        userDetailsLabel?.attributedText = NSAttributedString.attributedStringFor(user: review.appUser)
        reviewCommentLabel?.text = review.comment
        
        reviewableDetailsLabel?.text = "\(review.reviewable.title)\n"
        if let description = review.reviewable.description,
            let reviewableDetailsLabelText = reviewableDetailsLabel?.text {
            reviewableDetailsLabel?.text = reviewableDetailsLabelText + description
        }
        
        reviewableImageView?.image = UIImage.imageFrom(urlString: review.reviewable.titleImageUrl)
        emojiImageView?.image = UIImage(named: review.emojis + "Emoji")
    }
}
