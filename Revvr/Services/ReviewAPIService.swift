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
    static let shared = ReviewAPIService()
    
    let url = "service-api/review"
    
    /* ========================== CRUD ========================== */
    func get(id: Int, reviewableId: Int) -> Promise<Review> {
        let uri = "\(url)/\(id)?reviewableId=\(reviewableId)"
        return get(url: uri, type: Review.self)
    }
    
    func create(review: Review) -> Promise<Review> {
        return post(url: url, body: review, type: Review.self)
    }
    
    func update(id: Int, review: Review) -> Promise<Review> {
        let uri = "\(url)/\(id)"
        return put(url: uri, body: review, type: Review.self)
    }
    
    func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return delete(url: uri, type: Data.self)
    }
    
    /* ========================== List By... ========================== */
    func listByUser(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[Review]> {
        let uri = "\(url)/user/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [Review].self)
    }
    
    func listByReviewable(reviewable: Reviewable, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[Review]> {
        let uri = "\(url)/reviewable/\(reviewable.tpId)?tpName=\(reviewable.tpName)&order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [Review].self)
    }
    
    func listByFollowings(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[Review]> {
        let uri = "\(url)/following/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [Review].self)
    }
    
    /* ========================== Like ========================== */
    func like(reviewLike: ReviewLike) -> Promise<ReviewLike> {
        let uri = "\(url)/like"
        return post(url: uri, body: reviewLike, type: ReviewLike.self)
    }
    
    func deleteLike(id: Int, appUserId: Int) -> Promise<Data> {
        let uri = "\(url)/like/\(id)?appUserId=\(appUserId)"
        return delete(url: uri, type: Data.self)
    }
    
    /* ========================== Reply ========================== */
    func reply(reply: ReviewReply) -> Promise<ReviewReply> {
        let uri = "\(url)/reply"
        return post(url: uri, body: reply, type: ReviewReply.self)
    }
    
    func deleteReply(id: Int, appUserId: Int) -> Promise<Data> {
        let uri = "\(url)/reply/\(id)?appUserId=\(appUserId)"
        return delete(url: uri, type: Data.self)
    }
    
    func listReplies(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[ReviewReply]> {
        let uri = "\(url)/reply/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [ReviewReply].self)
    }
    
    /* ========================== Stats ========================== */
    func stats(id: Int) -> Promise<ReviewStats> {
        let uri = "\(url)/\(id)/stats"
        return get(url: uri, type: ReviewStats.self)
    }
}
