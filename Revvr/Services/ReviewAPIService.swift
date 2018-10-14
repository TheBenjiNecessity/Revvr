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
    static func get(id: Int, reviewableId: Int) -> Promise<Review> {
        let uri = "\(url)/\(id)?reviewableId=\(reviewableId)"
        return get(url: uri).then { data in
            return getModel(data: data, type: Review.self)
        }
    }
    
    static func create(review: Review) -> Promise<Review> {
        let reviewData = getData(model: review)
        return post(url: url, body: reviewData!).then { data in
            return getModel(data: data, type: Review.self)
        }
    }
    
    static func update(id: Int, review: Review) -> Promise<Review> {
        let uri = "\(url)/\(id)"
        let reviewData = getData(model: review)
        return post(url: uri, body: reviewData!).then { data in
            return getModel(data: data, type: Review.self)
        }
    }
    
    static func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return delete(url: uri)
    }
    
    /* ========================== List By... ========================== */
    static func listByUser(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/user/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri).then { data in
            return getModels(data: data, type: [Review].self)
        }
    }
    
    static func listByReviewable(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/reviewable/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri).then { data in
            return getModels(data: data, type: [Review].self)
        }
    }
    
    static func listByFollowings(id: Int, order: String, pageStart: Int, pageLimit: Int) -> Promise<[Review]> {
        let uri = "\(url)/list/followings/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri).then { data in
            return getModels(data: data, type: [Review].self)
        }
    }
    
    /* ========================== Like ========================== */
    static func like(reviewLike: ReviewLike) -> Promise<ReviewLike> {
        let uri = "\(url)/like"
        let reviewLikeData = getData(model: reviewLike)
        return post(url: uri, body: reviewLikeData!).then { data in
            return getModel(data: data, type: ReviewLike.self)
        }
    }
    
    static func deleteLike(id: Int, appUserId: Int) -> Promise<Data> {
        let uri = "\(url)/like/\(id)?appUserId=\(appUserId)"
        return delete(url: uri)
    }
}
