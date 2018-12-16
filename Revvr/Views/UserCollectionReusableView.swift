//
//  UserCollectionReusableView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-29.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

protocol UserSettingsDelegate: AnyObject {
    func showUserSettingsActionSheet()
    func follow(user: AppUser) -> Promise<AppUserFollowing>
    func unFollow(user: AppUser) -> Promise<Data>
}

class UserCollectionReusableView: UICollectionReusableView {
    var user = AppUser()
    weak var delegate: UserSettingsDelegate?
    
    var isFollowing: Bool = false {
        didSet {
            if let followButton = self.viewWithTag(222) as? UIButton {
                followButton.titleLabel?.text = isFollowing ? "Unfollow" : "Follow"
            }
        }
    }
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    static let reuseIdentifier = "UserCollectionReusableViewIdentifier"
    static let viewHeight = CGFloat(72.0)
    
    func setUser(user: AppUser) {
        self.user = user
        userLabel?.attributedText = NSAttributedString.attributedStringFor(user: user, of: CGFloat(17.0))
        
        AppUserAPIService.shared.get(followingId: user.id).then { following in
            self.isFollowing = true
        }.catch { error in
            self.isFollowing = false
        }
        
        AppUserAPIService.shared.getApiUser().then { apiUser in
            if self.user.id == apiUser.id {
                let settingsButton = self.viewWithTag(111)
                let followButton = self.viewWithTag(222)
                settingsButton?.isHidden = true
                followButton?.isHidden = true
            }
        }
    }
    
    @IBAction func follow(_ sender: Any) {
        if isFollowing {
            delegate?.unFollow(user: user).then{ _ in
                self.isFollowing = false
            }
        } else {
            delegate?.follow(user: user).then{ _ in
                self.isFollowing = true
            }
        }
    }
    
    @IBAction func settings(_ sender: Any) {
        delegate?.showUserSettingsActionSheet()
    }
}
