//
//  UserCollectionReusableView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-29.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class UserCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstLastNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    static let reuseIdentifier = "UserCollectionReusableViewIdentifier"
    static let viewHeight = CGFloat(72.0)
    
    func setUser(user: AppUser) {
        firstLastNameLabel?.text = user.firstName + " " + user.lastName
        userNameLabel?.text = user.handle
    }
}
