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
        
        emojiImageView?.image = UIImage(named: review.emojis + "Emoji")
        
        ReviewableAPIService.shared.get(tpId: review.reviewable.tpId, type: review.reviewable.tpName).then { reviewable in
            self.reviewableDetailsLabel?.attributedText = NSAttributedString.attributedString(for: reviewable)
            self.reviewableImageView?.image = UIImage.imageFrom(urlString: reviewable.titleImageUrl)
        }
    }
}
