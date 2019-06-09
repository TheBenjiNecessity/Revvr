//
//  ReviewsOnlyCollectionViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-29.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewsOnlyCollectionViewController: ReviewsCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = AppUserAPIService.shared.currentUser {
            self.showLoadingIndicator(show: true)
            ReviewAPIService.shared.listByFollowings(id: user.id).then { reviews in
                self.reviews = reviews
                self.refresh()
                self.showLoadingIndicator(show: false)
            }.catch { error in
                self.showLoadingIndicator(show: false)
            }
        } else {
            SessionService.shared.forcedLogout()
        }
    }
}
