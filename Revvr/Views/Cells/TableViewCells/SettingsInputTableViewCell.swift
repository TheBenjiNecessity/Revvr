//
//  SettingsInputTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingsInputTableViewCell: SettingTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!

    override func setItem(item: Item) {
        titleLabel?.text = item.title
        inputField?.text = item.value
    }
    
    override func getSelection() -> Any {
        return inputField?.text ?? ""
    }
}
