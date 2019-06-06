//
//  FollowingsTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

enum FollowType {
    case followers
    case followings
}

class FollowingsTableViewController: UITableViewController, FollowDelegate, UserDetailsViewDelegate {
    var user: AppUser = AppUser()
    var followings: [AppUser] = [] { didSet { self.tableView?.reloadData() } }
    var followType: FollowType = .followers

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        if followType == .followers {
            AppUserAPIService.shared.listFollowers(id: user.id).then { users in self.followings = users }
        } else {
            AppUserAPIService.shared.listFollowings(id: user.id).then { users in self.followings = users }
        }
    }
    
    func set(followType type: FollowType, for user: AppUser) {
        self.user = user
        self.followType = type
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.reuseIdentifier, for: indexPath) as! FollowingTableViewCell
        
        cell.user = followings[indexPath.row]
        
        cell.userDetailsView.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(54.0) //TODO remove magic number
    }
    
    func follow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.add(followingId: user.id)
    }
    
    func unFollow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.delete(followingId: user.id)
    }
    
    func didTap(with user: AppUser) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let uwrcvc = storyboard.instantiateViewController(withIdentifier: "UserWithReviewsCollectionViewController") as! UserWithReviewsCollectionViewController
        uwrcvc.user = user
        self.navigationController?.pushViewController(uwrcvc, animated: true)
    }
}
