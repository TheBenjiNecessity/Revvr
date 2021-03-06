//
//  Reviewable.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

struct Reviewable: Codable {
    let id: Int
    let tpId: String
    let tpName: String
    
    let title: String
    let type: String
    let description: String?
    let titleImageUrl: String?
    
    let reviewCount: Int?
    let emojiCounts: [String: Int]?
    
    let content: ReviewableContent?
    let info: ReviewableInfo?
    
    init() {
        tpId = ""
        tpName = ""
        title = ""
        type = ""
        id = -1
        description = nil
        titleImageUrl = nil
        reviewCount = nil
        emojiCounts = nil
        content = nil
        info = nil
    }
}
