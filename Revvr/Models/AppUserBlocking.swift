//
//  AppUserBlocking.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-30.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation

struct AppUserBlocking: Codable {
    let blockerId: Int
    let blockingId: Int
    
    init(blockerId: Int = -1, blockingId: Int = -1) {
        self.blockerId = blockerId
        self.blockingId = blockingId
    }
}
