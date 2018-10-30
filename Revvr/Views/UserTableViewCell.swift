//
//  UserTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-14.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstLastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let cellHeight = CGFloat(72.0)
    
    func setUser(user: AppUser) {
        //profilePictureImageView.image = user.content.profilePicture
        firstLastNameLabel?.text = "\(user.firstName) \(user.lastName)"
        usernameLabel?.text = user.handle
    }
}
