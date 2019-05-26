//
//  SettingSegmentTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingSegmentTableViewCell: SettingTableViewCell {
    private var segments: [String] = [] {
        didSet { self.accessoryView = UISegmentedControl(items: segments) }
    }
    
    override func setItem(item: Item) {
        super.setItem(item: item)

        if let segments = item.value?.components(separatedBy: ", ") {
            self.segments = segments
        }
    }
    
    override func getSelection() -> Any {
        let segmentedControl = self.accessoryView as! UISegmentedControl
        return segments[segmentedControl.selectedSegmentIndex]
    }
}
