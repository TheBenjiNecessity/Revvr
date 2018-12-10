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

class UserWithReviewsCollectionViewController: ReviewsCollectionViewController {
    var user = AppUser() {
        didSet {
            self.title = "\(user.firstName) \(user.lastName)"
            ReviewAPIService.shared.listByUser(id: user.id).then { reviews in
                self.reviews = reviews
                self.refresh()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let apiUser = SessionService.shared.user {
            hideSettingsButton(hide: user.id != apiUser.id)
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

        return userCollectionReusableView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettingsSegueIdentifier" {
            let json = """
            {
                "title": "Settings",
                "groups": [{
                    "title": "test",
                    "items": [{
                        "title": "subgroup",
                        "itemType": "setting",
                        "setting": {
                            "title": "Sub Settings",
                            "groups": [{
                                "title": "subgrouptest1",
                                "items": [{
                                    "title": "subgroupitem1",
                                    "itemType": "boolean"
                                }]
                            }]
                        }
                    },{
                        "title": "subtest1",
                        "itemType": "boolean"
                    }, {
                        "title": "subtest2",
                        "itemType": "info",
                        "value": "Benjamin"
                    }]
                }]
            }
            """.data(using: .utf8)!
            
            if let settings = try? JSONDecoder().decode(Setting.self, from: json) {
                let destination = segue.destination as! SettingsTableViewController
                destination.settings = settings
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func hideSettingsButton(hide: Bool) {
        if hide {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
        }
    }
    
    @objc func showSettings() {
        self.performSegue(withIdentifier: "ShowSettingsSegueIdentifier", sender: nil)
    }
}
