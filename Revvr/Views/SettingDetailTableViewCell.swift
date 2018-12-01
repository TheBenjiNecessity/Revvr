//
//  SettingDetailTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingDetailTableViewCell: SettingTableViewCell {
    override func setItem(item: Item) {
        super.setItem(item: item)
        
        self.detailTextLabel?.text = item.value as? String
    }
}
