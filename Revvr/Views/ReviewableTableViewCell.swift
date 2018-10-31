//
//  ReviewableTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-30.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewableTableViewCell: ModelTableViewCell {
    @IBOutlet weak var reviewableTitleLabel: UILabel!
    @IBOutlet weak var reviewableDescriptionLabel: UILabel!
    @IBOutlet weak var reviewableImageView: UIImageView!
    
    static let reuseIdentifier = "ReviewableTableViewCellIdentifier"
    static let cellHeight = CGFloat(101.0)
    
    override func setModel(model: Reviewable) {
        //reviewableImageView.image = reviewable...
        reviewableTitleLabel?.text = reviewable.title
        reviewableDescriptionLabel?.text = reviewable.description
    }
}
