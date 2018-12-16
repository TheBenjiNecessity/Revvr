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
        let nav = self.viewControllers![3] as! UINavigationController
        let uservc = nav.topViewController as! UserWithReviewsCollectionViewController
        
        AppUserAPIService.shared.getApiUser().then { user in
            uservc.user = user
        }
    }
}
