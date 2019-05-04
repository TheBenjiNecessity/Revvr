//
//  SliderTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-25.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SliderTableViewCellIdentifier"
    
    var gradation = 1
    
    var sliderValue: Float {
        get { return slider.value }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    func setLabels(leftLabel: String, rightLabel: String, description: String) {
        self.leftLabel.text = leftLabel
        self.rightLabel.text = rightLabel
        self.descriptionLabel.text = description
    }
    
    func initSlider(minValue: Float, maxValue: Float, currentValue: Float) {
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.setValue(currentValue, animated: false)
    }
}
