//
//  AppUserFollowing.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-11.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class AppUserFollowing: ModelObject {
    var followerId: Int
    var followingId: Int
    var created: Date
    
    override var data: Data? {
        get {
            var dict = [String: Any]()
            
            dict["followerId"] = followerId
            dict["followingId"] = followingId
            dict["created"] = ModelObject.dateStringForDate(date: created)

            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }
    
    required init?(json: [String: Any]) {        
        guard let followerId = json["followerId"] as? Int,
            let followingId = json["followingId"] as? Int,
            let created = json["created"] as? String
        else {
            return nil
        }
        
        self.followerId = followerId
        self.followingId = followingId
        self.created = ModelObject.dateFromDateString(dateString: created)!
        
        super.init(json: json)
    }
}
