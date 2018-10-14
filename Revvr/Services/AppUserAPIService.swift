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
    static let url = "appuser"
    
    /* ========================== CRUD ========================== */
    static func get(id: Int) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        return APIService.get(url: uri).then { data in
            return getModel(data: data, type: AppUser.self)
        }
    }
    
    static func get(handle: String) -> Promise<AppUser> {
        let uri = "\(url)/handle/\(handle)"
        return APIService.get(url: uri).then { data in
            return getModel(data: data, type: AppUser.self)
        }
    }
    
    static func create(user: AppUser) -> Promise<AppUser> {
        let userData = APIService.getData(model: user)
        return APIService.post(url: "appuser", body: userData!).then { data in
            return getModel(data: data, type: AppUser.self)
        }
    }
    
    static func update(id: Int, user: AppUser) -> Promise<AppUser> {
        let uri = "\(url)/\(id)"
        let userData = APIService.getData(model: user)
        return APIService.post(url: uri, body: userData!).then { data in
            return getModel(data: data, type: AppUser.self)
        }
    }
    
    static func delete(id: Int) -> Promise<Data> {
        let uri = "\(url)/\(id)"
        return APIService.delete(url: uri)
    }
    
    /* ========================== Followers ========================== */
    static func addFollower(follower: AppUserFollowing) -> Promise<Data> {
        let uri = "\(url)/follower"
        let followerData = APIService.getData(model: follower)
        return APIService.post(url: uri, body: followerData!)
    }
    
    static func deleteFollower(id: Int, followingId: Int) -> Promise<Data> {
        let uri = "\(url)/follower/\(id)?followingId=\(followingId)"
        return APIService.delete(url: uri)
    }

    static func listFollowers(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/followers/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return APIService.get(url: uri).then { data in
            return getModels(data: data, type: [AppUser].self)
        }
    }
    
    static func listFollowings(id: Int, order: String = "DESC", pageStart: Int = 0, pageLimit: Int = 20) -> Promise<[AppUser]> {
        let uri = "\(url)/followings/\(id)?order=\(order)&pageStart=\(pageStart)&pageLimit=\(pageLimit)"
        return APIService.get(url: uri).then { data in
            return getModels(data: data, type: [AppUser].self)
        }
    }
    
    /* ========================== Stats ========================== */
    static func getStats(id: Int) -> Promise<Data> {
        let uri = "\(url)/counts/\(id)"
        return APIService.get(url: uri)
    }
}
