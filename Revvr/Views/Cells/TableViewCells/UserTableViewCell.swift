//
//  UserTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-14.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class UserTableViewCell: ModelTableViewCell {
    @IBOutlet weak var userDetailsView: UserDetailsView!
    
    static let reuseIdentifier = "UserTableViewCellIdentifier"
    static let cellHeight = CGFloat(72.0)
    
    override func setModel(model: Any) {
        userDetailsView.setUserDetails(user: model as! AppUser)
    }
}
