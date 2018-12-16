//
//  AppUserFollowing.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-11.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct AppUserFollowing: Codable {
    let followerId: Int
    let followingId: Int
    let created: Date? //TODO this should be private/not settable
    
    init(followerId: Int = -1, followingId: Int = -1) {
        self.followerId = followerId
        self.followingId = followingId
        self.created = nil
    }
}
