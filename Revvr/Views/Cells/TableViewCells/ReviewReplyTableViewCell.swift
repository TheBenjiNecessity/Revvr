//
//  ReviewReplyTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewReplyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewReplyTableViewCellIdentifier"
    
    @IBOutlet weak var userDetailsView: UserDetailsView!
    @IBOutlet weak var commentLabel: UILabel!
    
    func setReply(reply: ReviewReply) {
        userDetailsView.setUserDetails(user: reply.appUser)
        commentLabel?.text = reply.comment
    }
}
