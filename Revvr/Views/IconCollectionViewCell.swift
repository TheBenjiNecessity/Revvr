//
//  IconCollectionViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-19.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    static let kClearCellsNotification = NSNotification.Name(rawValue: "kClearCellsNotification")
    static let reuseIdentifier = "IconCollectionViewCellIdentifier"
    @IBOutlet weak var iconImageView: UIImageView!
    var iconString = ""
    
    func setIcon(icon: String) {
        iconString = icon
        iconImageView?.image = UIImage(named: iconString + "Emoji")
        NotificationCenter.default.addObserver(self, selector: #selector(setUnselected), name: IconCollectionViewCell.kClearCellsNotification, object: nil)
    }
    
    @objc func setUnselected() {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setSelected() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }
}
