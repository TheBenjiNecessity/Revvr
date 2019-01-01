//
//  SettingTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    func setItem(item: Item) {
        self.textLabel?.text = item.title
    }
    
    func getSelection() -> Any { return 0 }
}
