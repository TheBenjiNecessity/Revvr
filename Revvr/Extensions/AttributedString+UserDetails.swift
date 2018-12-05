//
//  Label+UserDetails.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-24.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func attributedStringFor(user: AppUser) -> NSAttributedString {
        let userDetailsText = "\(user.firstName) \(user.lastName)\n\(user.handle)"
        let text = NSMutableAttributedString(string: userDetailsText)
        
        let nameLength = user.firstName.count + user.lastName.count + 1
        let nameRange = NSRange(location: 0, length: nameLength)
        let handleStart = nameLength + 2
        let handleRange = NSRange(location: handleStart, length: userDetailsText.count - handleStart)
        
        let nameAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.boldSystemFont(ofSize: CGFloat(17.0))
        ]
        text.addAttributes(nameAttributes, range: nameRange)
        
        let handleAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.systemFont(ofSize: 15.0)
        ]
        text.addAttributes(handleAttributes, range: handleRange)
        
        return text
    }
}
