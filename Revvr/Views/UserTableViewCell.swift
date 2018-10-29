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
    @IBOutlet weak var userInfoLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserInfoLabel(user: AppUser) {
        //profilePictureImageView.image = user.content.profilePicture ?? defaultProfilePicture
        let userInfoString: String = "\(user.firstName) \(user.lastName) \n \(user.handle)"
        
        userInfoLabel.text = userInfoString
    }
}
