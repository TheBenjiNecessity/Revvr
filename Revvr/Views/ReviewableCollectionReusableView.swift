//
//  ReviewableCollectionReusableView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-31.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewableCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var reviewableTitleLabel: UILabel!
    @IBOutlet weak var reviewableDescriptionLabel: UILabel!
    @IBOutlet weak var reviewableImageView: UIImageView!
    
    static let reuseIdentifier = "ReviewableCollectionReusableViewIdentifier"
    static let viewHeight = CGFloat(100.0)
    
    func setReviewable(reviewable: Reviewable) {
        //reviewableImageView?.image = reviewable.content...
        
        reviewableTitleLabel?.text = reviewable.title
        reviewableDescriptionLabel?.text = reviewable.description
    }
}
