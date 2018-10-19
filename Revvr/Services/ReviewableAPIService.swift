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
    static let url = "reviewable"
    
    static func get(id: Int) -> Promise<Reviewable> {
        let uri = "\(url)/\(id)"
        return APIService.get(url: uri).then { data in
            return getModel(data: data, type: Reviewable.self)
        }
    }
}