//
//  RadioPickerTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-27.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class RadioPickerTableViewCell: UITableViewCell {
    static let reuseIdentifier = "RadioPickerTableViewCellIdentifier"
    
    func createSwitchView(title: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        
        let switchView = UISwitch(frame: CGRect(x: 0, y: 0, width: 49, height: 31))
        switchView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(switchView)
        
        let views: [String: Any] = [
            "view": view,
            "titleLabel": titleLabel,
            "switchView": switchView
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[titleLabel]-[switchView]-|",
            options: [.alignAllCenterY],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
//        let switchViewHorizontalConstraints = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:[switchView]-|",
//            options: [.alignAllCenterY],
//            metrics: nil,
//            views: views)
//        allConstraints += switchViewHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
        
        return view
    }
    
    func addSubviews(subviews: [UIView]) {
        var previousView: UIView? = nil
        var allConstraints: [NSLayoutConstraint] = []
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        
        for subview in subviews {
            self.addSubview(subview)
            
            var views: [String: Any] = ["subview": subview]
            
            if let prevView = previousView {
                views["prevView"] = prevView
                
                let subviewVerticalConstraints = NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[prevView]-8-[subview(31)]",
                    metrics: nil,
                    views: views)
                allConstraints += subviewVerticalConstraints
            } else {
                //subview is first
                let subviewVerticalConstraints = NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-8-[subview(31)]",
                    metrics: nil,
                    views: views)
                allConstraints += subviewVerticalConstraints
            }
            
            let subviewHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[subview]-|",
                metrics: nil,
                views: views)
            allConstraints += subviewHorizontalConstraints
            
            previousView = subview
        }
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
