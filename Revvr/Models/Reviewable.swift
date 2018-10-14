//
//  Reviewable.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

struct Reviewable: Codable {
    let ID: Int?
    
    let title: String
    let reviewableType: String
    let reviewableDescription: String?
    let titleImageUrl: String?
    
    let reviewCount: Int
    let emojiCounts: [String: Int]
    
    let content: ReviewableContent
    let info: ReviewableInfo
}
