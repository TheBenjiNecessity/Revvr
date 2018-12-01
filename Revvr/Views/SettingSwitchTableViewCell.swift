//
//  SettingSwitchTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingSwitchTableViewCell: SettingTableViewCell {
    override func setItem(item: Item) {
        super.setItem(item: item)
        
        self.accessoryView = UISwitch(frame: .zero)
        if let isOn = item.value {
            (self.accessoryView as! UISwitch).setOn(isOn == "true", animated: false)
        }
    }
    
    override func getSelection() -> Any {
        let switchControl = self.accessoryView as! UISwitch
        return switchControl.isOn
    }
}
