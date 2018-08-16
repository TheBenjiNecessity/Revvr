//
//  ReviewAPIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

class ReviewAPIService: APIService {
    static let url = "reviews"
    
    /* ========================== CRUD ========================== */
    static func get(id: Int) -> Promise<Review> {
        let uri = "\(url)/\(id)"
        return APIService.get(url: uri).then { data in
            return getPromise(data: data, type: Review.self)
        }
    }
    
    static func create(review: Review) -> Promise<Review> {
        return APIService.post(url: url, body: review.data!).then { data in
            return getPromise(data: data, type: Review.self)
        }
    }
    
    static func update(id: Int, review: Review) -> Promise<Review> {
        let uri = "\(url)/\(id)"
        return APIService.post(url: uri, body: review.data!).then { data in
            return getPromise(data: data, type: Review.self)
        }
    }
    
    static func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return APIService.delete(url: uri)
    }
    
    /* ========================== List By... ========================== */
    static func listByUser(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/user/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return APIService.get(url: uri).then { data in
            return getArrayPromise(data: data, type: Review.self)
        }
    }
    
    static func listByReviewable(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/reviewable/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return APIService.get(url: uri).then { data in
            return getArrayPromise(data: data, type: Review.self)
        }
    }
    
    static func listByFollowings(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/followings/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return APIService.get(url: uri).then { data in
            return getArrayPromise(data: data, type: Review.self)
        }
    }
    
    /* ========================== Like ========================== */
    static func like(reviewLike: ReviewLike) -> Promise<ReviewLike> {
        let uri = "\(url)/like"
        return APIService.post(url: uri, body: reviewLike.data!).then { data in
            return getPromise(data: data, type: ReviewLike.self)
        }
    }
    
    static func deleteLike(id: Int) -> Promise<Data> {
        let uri = "\(url)/like/\(id)"
        return APIService.delete(url: uri)
    }
}
