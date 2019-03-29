//
//  TappableLabel.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-03-27.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol TappableLabelDelegate: AnyObject {
    func touchUpInside()
}

class TappableLabel: UILabel {
    let color = UIColor.darkGray
    weak var delegate: TappableLabelDelegate?
    
    @IBInspectable var range: NSRange = NSRange(location: 0, length: 0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let attributedString = self.attributedText else { return }
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

        let attributes: [NSAttributedStringKey: Any] = [
            .backgroundColor : self.color
        ]
        mutableAttributedString.addAttributes(attributes, range: self.range)
        
        

        self.attributedText = mutableAttributedString
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let attributedString = self.attributedText else { return }
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

        let attributes: [NSAttributedStringKey: Any] = [
            .backgroundColor : UIColor.clear
        ]
        mutableAttributedString.addAttributes(attributes, range: self.range)
        
        self.attributedText = mutableAttributedString

        self.delegate?.touchUpInside()
    }
}
