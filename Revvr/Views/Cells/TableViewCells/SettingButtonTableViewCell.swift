//
//  SettingButtonTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-01-01.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingButtonTableViewCell: SettingTableViewCell {
    @IBOutlet weak var cellButton: UIButton!
    
    override func setItem(item: Item) {
        cellButton.setTitle(item.title, for: UIControlState.normal)
    }
    
    @IBAction func cellButtonWasTapped(_ sender: Any) {
        print("tapped")
    }
}
