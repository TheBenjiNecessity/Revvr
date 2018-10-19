//
//  ReviewableAPIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

class ReviewableAPIService: APIService {
    static let url = "service-api/reviewable"
    
    static func get(id: Int) -> Promise<Reviewable> {
        let uri = "\(url)/\(id)"
        return get(url: uri, type: Reviewable.self)
    }
}
