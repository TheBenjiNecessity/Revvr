//
//  UserWithReviewsCollectionViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-28.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

// This page should have a user view at the top and sections of tableviews underneath
// those table view would be:
// - the user's reviews
// - the reviews of the user's followings

import UIKit
import Promises

class UserWithReviewsCollectionViewController: ReviewsCollectionViewController, UserSettingsDelegate {
    var user = AppUser() {
        didSet {
            self.title = "\(user.firstName) \(user.lastName)"
            self.showLoadingIndicator(show: true)
            self.reviewsPromise = ReviewAPIService.shared.listByUser(id: user.id)
            self.refresh()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = AppUserAPIService.shared.currentUser {
            self.hideSettingsButton(hide: self.user.id != currentUser.id)
        } else {
            SessionService.shared.forcedLogout()
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let userCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                         withReuseIdentifier: UserCollectionReusableView.reuseIdentifier,
                                                                                         for: indexPath) as! UserCollectionReusableView
        userCollectionReusableView.setUser(user: user)
        
        userCollectionReusableView.frame = CGRect(x: 0.0, y: 0.0, width: collectionView.frame.size.width, height: UserCollectionReusableView.viewHeight)
        
        userCollectionReusableView.delegate = self

        return userCollectionReusableView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettingsSegueIdentifier" {
            guard let path = Bundle.main.path(forResource: "settings", ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                let settings = try? JSONDecoder().decode(Setting.self, from: data)
            else { return }
            
            let userValues = [
                "#email#": user.email,
                "#password#": nil
            ]

            let destination = segue.destination as! SettingsTableViewController
            destination.settings = settings
            destination.values = userValues as [String : Any]
        } else if segue.identifier == "ShowFollowingsListSegueIdentifier" ||
            segue.identifier == "ShowFollowersListSegueIdentifier" {
            var type = FollowType.followers
            if segue.identifier == "ShowFollowingsListSegueIdentifier" {
                type = FollowType.followings
            }
            
            let fvc = segue.destination as! FollowingsTableViewController
            fvc.set(followType: type, for: user)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func hideSettingsButton(hide: Bool) {
        if hide {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(showSettings))
        }
    }
    
    func showUserSettingsActionSheet() {
        let userSettingsMenu = UIAlertController(title: "User Options", message: nil, preferredStyle: .actionSheet)

        let blockAction = UIAlertAction(title: "Block", style: .default) { action in
            // Show loading?
            AppUserAPIService.shared.getBlocking(blockingId: self.user.id).then { _ in
                AppUserAPIService.shared.block(blockingId: self.user.id).then { _ in
                    print("block success")
                }
            }.catch { error in
                //TODO: if error is 404
                AppUserAPIService.shared.unblock(blockingId: self.user.id).then { _ in
                    print("unblock success")
                }
            }
        }

        let reportAction = UIAlertAction(title: "Report", style: .default) { action in
            print("Report")
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        userSettingsMenu.addAction(blockAction)
        userSettingsMenu.addAction(reportAction)
        userSettingsMenu.addAction(cancelAction)

        self.present(userSettingsMenu, animated: true, completion: nil)
    }
    
    func follow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.add(followingId: user.id)
    }
    
    func unFollow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.delete(followingId: user.id)
    }
    
    func didTapInfoButton() {
        self.performSegue(withIdentifier: "ShowFiltersSegueIdentifier", sender: nil)
    }
    
    func didTapChangeFiltersButton() {
        self.performSegue(withIdentifier: "ProfileSegueIdentifier", sender: nil)
    }
    
    func didTapFollowersLabel() {
        self.performSegue(withIdentifier: "ShowFollowersListSegueIdentifier", sender: nil)
    }
    
    func didTapFollowingsLabel() {
        self.performSegue(withIdentifier: "ShowFollowingsListSegueIdentifier", sender: nil)
    }
    
    @objc func showSettings() {
        self.performSegue(withIdentifier: "ShowSettingsSegueIdentifier", sender: nil)
    }
}
