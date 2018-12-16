//
//  UserTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-14.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class UserTableViewCell: ModelTableViewCell {
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let reuseIdentifier = "UserTableViewCellIdentifier"
    static let cellHeight = CGFloat(72.0)
    
    override func setModel(model: Any) {
        let user = model as! AppUser
        
        //profilePictureImageView.image = user.content.profilePicture
        usernameLabel?.attributedText = NSAttributedString.attributedStringFor(user: user, of: CGFloat(17.0))
    }
}
