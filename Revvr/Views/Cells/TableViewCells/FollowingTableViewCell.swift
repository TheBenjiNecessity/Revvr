//
//  FollowingTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

protocol FollowDelegate: AnyObject {
    func follow(user: AppUser) -> Promise<AppUserFollowing>
    func unFollow(user: AppUser) -> Promise<AppUserFollowing>
}

class FollowingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FollowingTableViewCellIdentifier"
    weak var delegate: FollowDelegate?
    var isFollowing = false
    
    var user = AppUser() {
        didSet {
            let followButton = self.viewWithTag(333) as! UIButton
            
            userLabel?.attributedText = NSAttributedString.attributedStringFor(user: user, of: CGFloat(15.0))
            //profilePictureImageView?
            
            AppUserAPIService.shared.get(followingId: user.id).then { following in
                followButton.setTitle("Unfollow", for: UIControlState.normal)
            }.catch { error in
                followButton.setTitle("Follow", for: UIControlState.normal)
            }
            
            if let currentUser = AppUserAPIService.shared.currentUser {
                followButton.isHidden = self.user.id == currentUser.id
            } else {
                SessionService.shared.forcedLogout()
            }
        }
    }

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBAction func followButtonTap(_ sender: Any) {
        if isFollowing {
            delegate?.unFollow(user: user).then { _ in
                self.isFollowing = false
            }
        } else {
            delegate?.follow(user: user).then { _ in
                self.isFollowing = true
            }
        }
    }
}
