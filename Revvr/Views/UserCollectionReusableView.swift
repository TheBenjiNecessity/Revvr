//
//  UserCollectionReusableView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-29.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol UserSettingsDelegate: AnyObject {
    func showUserSettingsActionSheet()
}

class UserCollectionReusableView: UICollectionReusableView {
    var user = AppUser()
    weak var delegate: UserSettingsDelegate?
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstLastNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    static let reuseIdentifier = "UserCollectionReusableViewIdentifier"
    static let viewHeight = CGFloat(72.0)
    
    func setUser(user: AppUser) {
        self.user = user
        firstLastNameLabel?.text = user.firstName + " " + user.lastName
        userNameLabel?.text = user.handle
        
        if let apiUser = SessionService.shared.user {
            if user.id == apiUser.id {
                let settingsButton = self.viewWithTag(111)
                let followButton = self.viewWithTag(222)
                settingsButton?.isHidden = true
                followButton?.isHidden = true
            } else {
                AppUserAPIService.shared.user(withId: apiUser.id, isFollowingUserWithId: user.id).then { isFollowing in
                    if let followButton = self.viewWithTag(222) as? UIButton {
                        followButton.titleLabel?.text = "Unfollow"
                    }
                }
            }
        }
    }
    
    @IBAction func follow(_ sender: Any) {
        if let apiUser = SessionService.shared.user {
            let following = AppUserFollowing(followerId: apiUser.id, followingId: user.id)
            AppUserAPIService.shared.add(following: following).then { following in
                
            }
        }
    }
    
    @IBAction func settings(_ sender: Any) {
        delegate?.showUserSettingsActionSheet()
    }
}
