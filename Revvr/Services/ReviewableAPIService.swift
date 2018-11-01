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
    let url = "service-api/reviewable"
    
    func get(id: Int) -> Promise<Reviewable> {
        let uri = "\(url)/\(id)"
        return get(url: uri, type: Reviewable.self)
    }
    
    func search(text: String, pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[Reviewable]> {
        let uri = "\(url)/search?text=\(text)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [Reviewable].self)
    }
}
