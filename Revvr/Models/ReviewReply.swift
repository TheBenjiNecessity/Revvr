//
//  ReviewReply.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation

struct ReviewReply: Codable {
    let appUserID: Int
    let reviewID: Int
    let comment: String
    let created: Date?
    
    let AppUser: AppUser // The user who left the reply
    let Review: Review
}
