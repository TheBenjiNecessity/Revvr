//
//  ReviewLike.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-13.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct ReviewLike: Codable {
    let appUserID: Int
    let reviewID: Int
    let type: String
    let created: Date?
}
