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
    
    static let shared = ReviewableAPIService()
    
    func get(tpId: String, type: String) -> Promise<Reviewable> {
        let uri = "\(url)/\(tpId)?type=\(type)"
        return get(url: uri, type: Reviewable.self)
    }
    
    func search(text: String, type: String, pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[Reviewable]> {
        let uri = "\(url)/search/\(text)?type=\(type)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [Reviewable].self)
    }
    
    /* ========================== JSON objects ========================== */
    func getContent(id: Int) -> Promise<ReviewableContent> {
        let uri = "\(url)/\(id)/content"
        return get(url: uri, type: ReviewableContent.self)
    }
    
    func getInfo(id: Int) -> Promise<ReviewableInfo> {
        let uri = "\(url)/\(id)/info"
        return get(url: uri, type: ReviewableInfo.self)
    }
}
