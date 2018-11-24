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
        //let handleRange = NSRange(location: nameLength + 2, length: userDetailsText.count)
        
        text.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: CGFloat(12.0)), range: nameRange)
        //text.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: CGFloat(12.0)), range: handleRange)
        
        return text
    }
}
