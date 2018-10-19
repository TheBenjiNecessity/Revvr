//
//  AppUserAPIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

class AppUserAPIService: APIService {
    static let url = "service-api/appuser"
    
    /* ========================== CRUD ========================== */
    static func getApiUser() -> Promise<AppUser> {
        let uri = "\(url)"
        return get(url: uri, type: AppUser.self)
    }
    
    static func get(id: Int) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        return get(url: uri, type: AppUser.self)
    }
    
    static func get(handle: String) -> Promise<AppUser> {
        let uri = "\(url)/handle/\(handle)"
        return get(url: uri, type: AppUser.self)
    }
    
    static func search(text: String, pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/search"
        return get(url: uri, type: [AppUser].self)
    }
    
    static func create(user: AppUser) -> Promise<AppUser> {
        let userData = getData(model: user)
        return post(url: url, body: userData!, type: AppUser.self)
    }
    
    static func update(id: Int, user: AppUser) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        let userData = getData(model: user)
        return post(url: uri, body: userData!, type: AppUser.self)
    }
    
    static func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return delete(url: uri, type: Data.self)
    }
    
    /* ========================== Followers ========================== */
    static func addFollower(follower: AppUserFollowing) -> Promise<Data> {
        let uri = "\(url)/follower"
        let followerData = getData(model: follower)
        return post(url: uri, body: followerData!, type: Data.self)
    }
    
    static func deleteFollower(id: Int, followingId: Int) -> Promise<Data> {
        let uri = "\(url)/follower/\(id)?followingId=\(followingId)"
        return delete(url: uri, type: Data.self)
    }

    static func listFollowers(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/followers/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [AppUser].self)
    }
    
    static func listFollowings(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/followings/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [AppUser].self)
    }
    
    /* ========================== Stats ========================== */
    static func getStats(id: Int) -> Promise<Data> {
        let uri = "\(url)/counts/\(id)"
        return get(url: uri, type: Data.self)
    }
}
