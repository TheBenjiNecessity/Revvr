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
    static func attributedStringFor(user: AppUser, of fontSize: CGFloat) -> NSAttributedString {
        let userDetailsText = "\(user.firstName) \(user.lastName)\n\(user.handle)"
        let text = NSMutableAttributedString(string: userDetailsText)
        
        let nameLength = user.firstName.count + user.lastName.count + 1
        let nameRange = NSRange(location: 0, length: nameLength)
        let handleStart = nameLength + 1
        let handleRange = NSRange(location: handleStart, length: userDetailsText.count - handleStart)
        
        let nameAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.boldSystemFont(ofSize: fontSize)
        ]
        text.addAttributes(nameAttributes, range: nameRange)
        
        let handleAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.systemFont(ofSize: fontSize - 2)
        ]
        text.addAttributes(handleAttributes, range: handleRange)
        
        return text
    }
    
    static func attributedString(for reviewable: Reviewable) -> NSAttributedString {
        let reviewableText = "\(reviewable.title)\n\(reviewable.description ?? "")"
        let text = NSMutableAttributedString(string: reviewableText)
        
        let titleLength = reviewable.title.count
        let titleRange = NSRange(location: 0, length: titleLength)
        let descriptionStart = titleLength + 1
        let descriptionRange = NSRange(location: descriptionStart, length: reviewableText.count - descriptionStart)
        
        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.boldSystemFont(ofSize: CGFloat(17.0))
        ]
        text.addAttributes(titleAttributes, range: titleRange)
        
        let descriptionAttributes: [NSAttributedStringKey: Any] = [
            .font : UIFont.systemFont(ofSize: 15.0)
        ]
        text.addAttributes(descriptionAttributes, range: descriptionRange)
        
        return text
    }
}
