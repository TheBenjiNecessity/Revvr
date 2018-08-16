//
//  ReviewLike.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-13.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewLike: ModelObject {
    var appUserID: Int
    var reviewID: Int
    var type: String
    var created: Date
    
    override var data: Data? {
        get {
            var dict = [String: Any]()
            
            dict["appUserID"] = appUserID
            dict["reviewID"] = reviewID
            dict["type"] = type
            dict["created"] = ModelObject.dateStringForDate(date: created)
            
            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }
    
    required init?(json: [String: Any]) {
        guard let appUserID = json["appUserID"] as? Int,
            let reviewID = json["reviewID"] as? Int,
            let type = json["type"] as? String,
            let created = json["created"] as? String
            else {
                return nil
        }
        
        self.appUserID = appUserID
        self.reviewID = reviewID
        self.type = type
        self.created = ModelObject.dateFromDateString(dateString: created)!
        
        super.init(json: json)
    }
}
