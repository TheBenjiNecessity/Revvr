//
//  MainTabbarViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-31.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.viewControllers![2] as! UINavigationController
        let uservc = nav.topViewController as! UserWithReviewsCollectionViewController

        if let user = AppUserAPIService.shared.currentUser {
            uservc.user = user
        } else {
            SessionService.shared.forcedLogout()
        }
    }
}
