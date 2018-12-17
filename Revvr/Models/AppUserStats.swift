//
//  AppUserStats.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation

struct AppUserStats: Codable {
    let followerCount: Int
    let followingCount: Int
    let likeCount: Int
    let recommendationCount: Int
    let reviewCount: Int
}
