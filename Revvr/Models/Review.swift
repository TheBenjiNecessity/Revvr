//
//  Review.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct Review: Codable {
    let ID: Int?
    
    let appUserID: Int
    let reviewableID: Int
    let title: String?
    let created: Date?
    let comment: String?
    let emojis: String
    
    let appUser: AppUser
    let reviewable: Reviewable
}
