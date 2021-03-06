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
    func unFollow(user: AppUser) -> Promise<AppUserFollowing>
    func didTapInfoButton()
    func didTapChangeFiltersButton()
    func didTapFollowersLabel()
    func didTapFollowingsLabel()
}

class UserCollectionReusableView: UICollectionReusableView {
    var user = AppUser()
    weak var delegate: UserSettingsDelegate?
    
    var isFollowing: Bool = false {
        didSet {
            if let followButton = self.viewWithTag(222) as? UIButton {
                let titleText = isFollowing ? "Unfollow" : "Follow"
                followButton.setTitle(titleText, for: UIControlState.normal)
            }
        }
    }
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userDetailsView: UserDetailsView!
    @IBOutlet weak var followingsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var changeFiltersButton: UIButton!
    
    static let reuseIdentifier = "UserCollectionReusableViewIdentifier"
    static let viewHeight = CGFloat(76.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let followingsTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                    action: #selector(didTapFollowingsLabel))
        followingsTapGestureRecognizer.numberOfTapsRequired = 1
        followingsLabel.addGestureRecognizer(followingsTapGestureRecognizer)
        
        let followersTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                   action: #selector(didTapFollowersLabel))
        followersTapGestureRecognizer.numberOfTapsRequired = 1
        followersLabel.addGestureRecognizer(followersTapGestureRecognizer)
        
        editProfileButton.layer.borderWidth = 1.0
        editProfileButton.layer.borderColor = UIColor.black.cgColor
        editProfileButton.layer.cornerRadius = 5.0
        editProfileButton.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15)
        
        changeFiltersButton.layer.borderWidth = 1.0
        changeFiltersButton.layer.borderColor = UIColor.black.cgColor
        changeFiltersButton.layer.cornerRadius = 5.0
        changeFiltersButton.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15)
    }
    
    func setUser(user: AppUser) {
        self.user = user
        //userLabel?.attributedText = NSAttributedString.attributedStringFor(user: user, of: CGFloat(17.0))
        
        userDetailsView.setUserDetails(user: user)
        
        AppUserAPIService.shared.get(followingId: user.id).then { following in
            self.isFollowing = true
        }.catch { error in
            self.isFollowing = false
        }
        
        if let currentUser = AppUserAPIService.shared.currentUser {
            if self.user.id == currentUser.id {
                let settingsButton = self.viewWithTag(111)
                let followButton = self.viewWithTag(222)
                settingsButton?.isHidden = true
                followButton?.isHidden = true
            } else {
                editProfileButton.isHidden = true
                changeFiltersButton.isHidden = true
            }
        } else {
            SessionService.shared.forcedLogout()
        }
        
        AppUserAPIService.shared.getStats(id: self.user.id).then { stats in
            self.followingsLabel?.text = "\(stats.followingCount) Followings"
            self.followersLabel?.text = "\(stats.followerCount) Followers"
        }
    }
    
    @IBAction func follow(_ sender: Any) {
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
    
    @IBAction func settings(_ sender: Any) {
        delegate?.showUserSettingsActionSheet()
    }
    
    @IBAction func info(_ sender: Any) {
        delegate?.didTapInfoButton()
    }
    
    @IBAction func changeFilters(_ sender: Any) {
        delegate?.didTapChangeFiltersButton()
    }
    
    @objc func didTapFollowingsLabel() {
        delegate?.didTapFollowingsLabel()
    }
    
    @objc func didTapFollowersLabel() {
        delegate?.didTapFollowersLabel()
    }
}
