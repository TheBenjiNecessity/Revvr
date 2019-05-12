//
//  RangeSliderTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-14.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class RangeSliderTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, FilterTableViewCell {
    var value: Any {
        get { return "\(leftValue),\(rightValue)" }
    }
    
    static let reuseIdentifier = "RangeSliderTableViewCellIdentifier"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var minValue = 0
    var maxValue = 100000000
    var minimumDistance = 0
    
    var leftValue: Int {
        get { return self.picker.selectedRow(inComponent: 0) }
    }
    
    var rightValue: Int {
        get { return self.picker.selectedRow(inComponent: 1) }
    }
    
    func setTitleLabelText(text: String) {
        titleLabel.text = text
    }
    
    func setValues(minValue: Int, maxValue: Int, minimumDistance: Int, lValue: Int?, rValue: Int?) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.minimumDistance = minimumDistance
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.picker.selectRow(lValue ?? minValue, inComponent: 0, animated: false)
        self.picker.selectRow(rValue ?? maxValue, inComponent: 1, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int((maxValue - minValue) / minimumDistance) + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row * minimumDistance + minValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let leftRow = picker.selectedRow(inComponent: 0)
        let rightRow = picker.selectedRow(inComponent: 1)
        
        if leftRow > rightRow {
            if component == 0 {
                picker.selectRow(leftRow, inComponent: 1, animated: true)
            } else {
                picker.selectRow(rightRow, inComponent: 0, animated: true)
            }
        }
    }
}
