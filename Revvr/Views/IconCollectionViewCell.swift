//
//  IconCollectionViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-19.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "IconCollectionViewCellIdentifier"
    @IBOutlet weak var iconImageView: UIImageView!
    var iconString = ""
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setIcon(icon: String) {
        iconString = icon
        iconImageView?.image = UIImage(named: iconString + "Emoji")
    }
}
