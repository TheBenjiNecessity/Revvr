//
//  EmojiTabButton.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-21.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

@IBDesignable
class EmojiTabButton: UIButton {
    override func draw(_ rect: CGRect) {
        let bgColor = UIColor.blue
        let faceColor = UIColor.white
        
        // Set background tab
        let bottomHalfRect = CGRect(x: rect.origin.x, y: rect.origin.y + (rect.size.height / 2), width: rect.size.width, height: rect.size.height / 2)
        let circle = UIBezierPath(ovalIn: rect)
        let square = UIBezierPath(rect: bottomHalfRect)
        bgColor.setFill()
        circle.fill()
        square.fill()
        
        // Set head
        let padding = CGFloat(10.0)
        let width = rect.size.width - padding
        let height = rect.size.height - padding
        let faceRect = CGRect(x: (rect.size.width / 2) - (width / 2), y: (rect.size.height / 2) - (height / 2), width: width, height: height)
        let faceOuter = UIBezierPath(ovalIn: faceRect)
        faceColor.setStroke()
        faceOuter.stroke()
        
        // Set eyes
        faceColor.setFill()
        let eyeSize = CGFloat(3.0)
        let eyePositionY = (rect.size.height / 2) - CGFloat(5.0)
        
        // Set left eye
        let leftEyeRect = CGRect(x: (rect.size.width / 2) - (CGFloat(2.0) + eyeSize), y: eyePositionY, width: eyeSize, height: eyeSize)
        let leftEye = UIBezierPath(ovalIn: leftEyeRect)
        leftEye.fill()
        
        // Set right eye
        let rightEyeRect = CGRect(x: (rect.size.width / 2) + CGFloat(2.0), y: eyePositionY, width: eyeSize, height: eyeSize)
        let rightEye = UIBezierPath(ovalIn: rightEyeRect)
        rightEye.fill()
        
        // Set smile
        let smileOffsetY = CGFloat(1.0)
        let arcCenter = CGPoint(x: faceRect.origin.x + faceRect.size.width / 2, y: faceRect.origin.y + faceRect.size.height / 2 + smileOffsetY)
        let radius = CGFloat(5.0)
        let startAngle = CGFloat(0.0)
        let endAngle = CGFloat.pi
        let smile = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        smile.stroke()
    }
}
