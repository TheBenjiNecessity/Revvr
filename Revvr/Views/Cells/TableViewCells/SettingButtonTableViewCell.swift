//
//  SettingButtonTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-01-01.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol SettingButtonTableViewCellDelegate: AnyObject {
    func didPressSettingsButton(with item: Item?)
}

class SettingButtonTableViewCell: SettingTableViewCell {
    @IBOutlet weak var cellButton: UIButton!
    
    var item: Item?
    weak var delegate: SettingButtonTableViewCellDelegate?
    
    override func setItem(item: Item) {
        self.item = item
        cellButton.setTitle(item.title, for: UIControlState.normal)
    }
    
    @IBAction func cellButtonWasTapped(_ sender: Any) {
        delegate?.didPressSettingsButton(with: item)
    }
}
