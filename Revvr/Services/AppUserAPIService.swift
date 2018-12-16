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
    let url = "service-api/appuser"
    
    static let shared = AppUserAPIService()
    
    override init() {}
    
    /* ========================== CRUD ========================== */
    func getApiUser() -> Promise<AppUser> {
        return get(url: url, type: AppUser.self)
    }
    
    func get(id: Int) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        return get(url: uri, type: AppUser.self)
    }
    
    func get(handle: String) -> Promise<AppUser> {
        let uri = "\(url)/handle/\(handle)"
        return get(url: uri, type: AppUser.self)
    }
    
    func search(text: String, pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/search/\(text)?pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [AppUser].self)
    }
    
    func create(user: AppUser) -> Promise<AppUser> {
        return post(url: url, body: user, type: AppUser.self)
    }
    
    func update(id: Int, user: AppUser) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        return put(url: uri, body: user, type: AppUser.self)
    }
    
    func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return delete(url: uri, type: Data.self)
    }
    
    /* ========================== Followers ========================== */
    func add(followingId: Int) -> Promise<AppUserFollowing> {
        let uri = "\(url)/following/\(followingId)"
        return post(url: uri, body: AppUserFollowing(), type: AppUserFollowing.self)
    }
    
    func delete(followingId: Int) -> Promise<Data> {
        let uri = "\(url)/following/\(followingId)"
        return delete(url: uri, type: Data.self)
    }
    
    func get(followingId: Int) -> Promise<AppUserFollowing> {
        let uri = "\(url)/following/\(followingId)"
        return get(url: uri, type: AppUserFollowing.self)
    }

    func listFollowers(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/\(id)/followers?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [AppUser].self)
    }
    
    func listFollowings(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/\(id)/followings?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return get(url: uri, type: [AppUser].self)
    }
    
    /* ========================== Stats ========================== */
    func getStats(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)/counts"
        return get(url: uri, type: Data.self)
    }
}
